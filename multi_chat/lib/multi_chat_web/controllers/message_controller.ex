defmodule MultiChatWeb.MessageController do
  use MultiChatWeb, :controller

  alias MultiChat.Messages

  def index(conn, _params) do
    messages = Messages.list_messages()
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"message" => message_text}) do
    message = Messages.create_message(%{body: message_text, user_id: 0, user_email: "admin@localhost", sent_at: DateTime.utc_now()})
    render(conn, "message.json", message: message)
  end
end
