defmodule AwsConsumer.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      AwsConsumer.QueueConsumer
    ]

    opts = [strategy: :one_for_one, name: AwsConsumer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
