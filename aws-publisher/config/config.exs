use Mix.Config

config :aws_publisher,
  topic: System.get_env("AWS_SNS_TOPIC") 
