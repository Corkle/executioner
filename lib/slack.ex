defmodule Executioner.Slack do
  use Slack
  alias Executioner.Router

  def start_link(token), do:
    Slack.Bot.start_link(__MODULE__, [], token)

  def handle_connect(slack, state) do
    IO.puts("SLACK CONNECTED")
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state), do:
    handle_message(Router.process(message, slack, state), slack)

  def handle_event(_, _, state), do:
    {:ok, state}

  defp handle_message({:no_reply, _, state}, slack) do
    IO.puts("NO_REPLY")
    {:ok, state}
  end

  defp handle_message({channel, text, state}, slack) do
    IO.puts("TO #{channel}: #{text}")
    send_message(text, channel, slack)
    {:ok, state}
  end
end

