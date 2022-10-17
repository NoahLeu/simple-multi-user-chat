defmodule MultiChatWeb.RoomChannel do
  use Phoenix.Channel

  alias Phoenix.Channel
  alias Phoenix.PubSub

  @topic "message_updates"

  @impl true
  def join("room:message_updates", _message, socket) do
    PubSub.subscribe(MultiChat.PubSub, @topic)

    {:ok, socket}
  end

  @impl true
  def handle_info(msg, socket) do
    msg
    |> IO.inspect(label: "handle_info")
    case msg.event do
      "new_msg" ->
        Channel.broadcast!(socket, "new_msg", %{body: msg.body.body})
      "delete_msg" ->
        Channel.broadcast!(socket, "delete_msg", %{body: msg})
      _ ->
        IO.puts("Unknown event")
    end

    {:noreply, socket}


    {:noreply, socket}
  end

  # TODO: handle delete messages

end
