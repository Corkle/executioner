defmodule Executioner.Router do
  def process(%{channel: "D" <> _} = message, slack, state), do:
    handle_direct_message(message, slack, state)

  def process(%{text: "<@U3QRANNP4>" <> _, channel: ch}, slack, state), do:
    {ch, "I will end you soon enough...", state}

  def process(message, slack, state) do
    IO.inspect(message)
    {:no_reply, nil, state}
  end

  defp handle_direct_message(message, slack, state) do
    IO.puts("DIRECT_MESSAGE")
    {message.channel, "You said: #{message.text}", state}
  end
end

