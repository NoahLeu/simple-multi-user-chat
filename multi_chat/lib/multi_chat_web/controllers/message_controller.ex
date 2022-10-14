defmodule MultiChatWeb.MessageController do
  use MultiChatWeb, :controller

  alias MultiChat.Messages
  alias Phoenix.PubSub

  @topic "message_updates"
  

  def index(conn, _params) do
    messages = Messages.list_messages()
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"message" => message_text}) do
    new_msg = %{body: message_text, user_id: 0, user_email: "admin@localhost", sent_at: DateTime.utc_now()}
    message = Messages.create_message(new_msg)

    PubSub.broadcast(MultiChat.PubSub, @topic, %{event: "new_msg", body: new_msg})

    render(conn, "message.json", message: message)
  end
end
