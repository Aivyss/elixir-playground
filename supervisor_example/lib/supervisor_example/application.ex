defmodule SupervisorExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {SimpleQueue, [1,2,3]}
    ]

    # strategies
    ## one_for_one: 失敗した子プロセスだけ再起動する
    ## one_for_all: 失敗した子プロセスがあったら、全ての子プロセスを再起動する
    ## rest_for_one: 失敗した子プロセスとその後生成された全ての子プロセスを再起動する
    opts = [strategy: :one_for_one, name: SupervisorExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
