defmodule AwsConsumerTest do
  use ExUnit.Case
  doctest AwsConsumer

  test "greets the world" do
    assert AwsConsumer.hello() == :world
  end
end
