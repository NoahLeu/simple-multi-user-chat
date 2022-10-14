defmodule MultiChatWeb.MessageController do
  use MultiChatWeb, :controller

  alias MultiChat.Messages

  def index(conn, _params) do
    messages = Messages.list_messages()
    render(conn, "index.json", messages: messages)
  end
end
