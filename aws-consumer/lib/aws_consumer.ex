defmodule AwsConsumer do
  @moduledoc "Collection of functions demonstrating how to use ExAws.SQS and ExAws.SNS"

  alias ExAws.SQS

  def delete_message(queue_url, receipt) do
    queue_url
    |> SQS.delete_message(receipt)
    |> ExAws.request()
  end
end
