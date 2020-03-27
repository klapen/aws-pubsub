use Mix.Config

config :aws_consumer,
  queue_name: System.get_env("AWS_QUEUE_NAME"),
  account_id: System.get_env("AWS_ACCOUNT_ID"),
  topic_name: System.get_env("AWS_TOPIC_NAME")

config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
  region: System.get_env("AWS_REGION")
