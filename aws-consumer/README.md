# AwsConsumer

This proyect implements [ExAws.SQS](https://hexdocs.pm/ex_aws_sqs/ExAws.SQS.html) to cconsume messages sent to AWS SQS, in [Elixir](https://elixir-lang.org/), and delete the message after consume it.

## Folder structure
```
├── config
│   └── config.exs
├── lib
│   ├── application.ex
│   ├── aws_consumer.ex
│   └── queue_consumer.ex
├── mix.exs
├── mix.lock
├── README.md
└── test
    ├── aws_consumer_test.exs
    └── test_helper.exs
```

## Dependencies

- [ExAws](https://hexdocs.pm/ex_aws/ExAws.html)
- [ExAws.SQS](https://hexdocs.pm/ex_aws_sqs/ExAws.SQS.html)
- [SweetXml](https://hexdocs.pm/sweet_xml/SweetXml.html)
- [Jason](https://hexdocs.pm/jason/Jason.html)
- [Hackney](https://hexdocs.pm/hackney/)

## Prerequisite

First of all, you need to configure a [SQS queue](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-getting-started.html) in AWS and create a [security credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html).

**Note**: If you have a SNS to push messages on the SQS, remember to configure the SQS permission policy:

```
{
  "Version": "2012-10-17",
  "Id": "{queue_arn}/SQSDefaultPolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "sqs:SendMessage",
      "Resource": "{queue_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "{sns_topic_arn}"
        }
      }
    }
  ]
}
```

Once you have the queue, set all required enviroment variables:


```sh
$ export AWS_QUEUE_NAME={queue_name}
$ export AWS_ACCOUNT_ID={account_id}
$ export AWS_TOPIC_NAME={topic_name}
$ export AWS_SECRET_ACCESS_KEY={user_account_secret_access}
$ export AWS_ACCESS_KEY_ID={user_account_access_key}
$ export AWS_REGION={sqs_region}
```

Then install all dependencies:


```sh
$ mix deps.get
```

## How to use

To use, just open a console and use the method *AwsPublisher.publish_message*:

```sh
$ cd path/to/publisher
$ iex -S mix

```

And start to send messages, the console will start to log the recived messages.
