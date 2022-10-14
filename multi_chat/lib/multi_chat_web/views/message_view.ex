defmodule MultiChatWeb.MessageView do
  use MultiChatWeb, :view

  def render("index.json", %{messages: messages}) do
    %{
      data: %{messages: render_many(messages, MultiChatWeb.MessageView, "message.json")},
      status: "success"
    }
  end

  def render("message.json", %{message: message}) do
    %{
      message_id: message.message_id,
      body: message.body,
      sent_at: message.sent_at,
      user_email: message.user_email,
      user_id: message.user_id
    }
  end
end
