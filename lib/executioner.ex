defmodule Executioner do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    slack_token = Application.get_env(:executioner, Executioner.Slack)[:token]

    IO.puts("STARTING APP")

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Executioner.Worker.start_link(arg1, arg2, arg3)
      # worker(Executioner.Worker, [arg1, arg2, arg3]),
      worker(Executioner.Slack, [slack_token])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Executioner.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
