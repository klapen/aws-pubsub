# Publisher to AWS SNS

This proyect implements [ExAws.SNS](https://hexdocs.pm/ex_aws_sns/ExAws.SNS.html) to publish messages to an AWS SNS Topic, in [Elixir](https://elixir-lang.org/).

## Folder structure
```
.
├── config
│   └── config.exs
├── lib
│   └── aws_publisher.ex
├── mix.exs
├── mix.lock
├── README.md
└── test
    ├── aws_publisher_test.exs
    └── test_helper.exs
```

## Dependencies

- [ExAws](https://hexdocs.pm/ex_aws/ExAws.html)
- [ExAws](https://hexdocs.pm/ex_aws_sns/ExAws.SNS.html)
- [SweetXml](https://hexdocs.pm/sweet_xml/SweetXml.html)
- [Jason](https://hexdocs.pm/jason/Jason.html)
- [Hackney](https://hexdocs.pm/hackney/)

## Prerequisite

First of all, you need to configure a [SNS topic](https://docs.aws.amazon.com/sns/latest/dg/sns-getting-started.html) in AWS and create a [security credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html).

Once you have the ARN, set all required enviroment variables:

```sh
$ export AWS_SECRET_ACCESS_KEY={user_account_secret_access}
$ export AWS_ACCESS_KEY_ID={user_account_access_key}
$ export AWS_SNS_TOPIC=arn:aws:sns:{region}:{account_id}:{topic_name}
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
iex(5)> AwsPublisher.publish_message("Some title", %{"age" => 44, "name" => "Jhon Doe", "nationality" => "Colombian"})

```
