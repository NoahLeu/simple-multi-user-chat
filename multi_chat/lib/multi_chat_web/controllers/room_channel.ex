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
    Channel.broadcast!(socket, "new_msg", %{body: msg.body.body})

    "hi"
    |> IO.inspect(label: "handle_info")

    {:noreply, socket}
  end

  # TODO: handle delete messages

end
