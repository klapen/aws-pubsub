defmodule AwsConsumer.QueueConsumer do
  @moduledoc """
  Consumes messages from a Queue SQS
  """
  alias ExAws.SQS

  require Logger

  use GenServer

  
  @queue_name Application.fetch_env!(:aws_consumer, :queue_name)
  @account_id Application.fetch_env!(:aws_consumer, :account_id)
  @topic_name Application.fetch_env!(:aws_consumer, :topic_name)
  @region Application.fetch_env!(:ex_aws, :region)
  @queue_url "https://sqs.#{@region}.amazonaws.com/#{@account_id}/#{@queue_name}"
  @topic_arn "arn:aws:sns:#{@region}:#{@account_id}:#{@topic_name}"

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    Logger.debug("Setting up queue #{@queue_name} and subscription to topic #{@topic_arn}")
    schedule_check()
    {:ok, %{queue_name: @queue_name, last_message_time: nil}}
  end

  def schedule_check(check_interval \\ 1_000) do
    Process.send_after(self(), :get_messages, check_interval)
  end

  def handle_messages() do
    case get_messages(@queue_url, wait_time_seconds: 5, max_number_of_messages: 10) do
      {:ok, []} ->
        Logger.info("No message to process")
        :ok

      {:ok, messages} ->
        Logger.info(
          "Received #{length(messages)} messages from queue #{@queue_name}, processing them..."
        )

        process_messages(messages)

        messages
        |> Enum.each(fn %{receipt_handle: receipt_handle} ->
          Logger.debug("Deleting message with receipt: #{receipt_handle}")
          AwsConsumer.delete_message(@queue_url, receipt_handle)
        end)

      {:error, _} = unexpected ->
        Logger.error(
          "Could not get messages from queue #{@queue_name}, reason: #{inspect(unexpected)}"
        )
    end
  end

  defp get_messages(queue_url, opts) do
    result =
      queue_url
      |> SQS.receive_message(opts)
      |> ExAws.request()

    with {:ok, %{body: %{messages: messages}}} <- result, do: {:ok, messages}
  end

  def process_messages(messages) do
    Enum.each(messages, fn message ->
      Logger.info("Handling message: #{inspect(message)}")
      case Jason.decode(message.body) do
        {:ok, json} ->
          Logger.info("Recieved JSON: #{inspect(json)}")

        {:error, _} ->
          Logger.info("Recieves string: #{inspect{message.body}}")
      end
    end)

    messages
  end

  @impl GenServer
  def handle_info(:get_messages, state) do
    handle_messages()
    schedule_check()

    {:noreply, state}
  end

  def handle_info(:sslsocket, _) do
    Logger.info("SSL socker closed")

    {:sslsocket}
  end
end
