defmodule MultiChatWeb.PageLive do
  use MultiChatWeb, :live_view

  alias MultiChat.Accounts
  alias MultiChat.Messages
  alias Phoenix.PubSub

  @topic "message_updates"

  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    messages = Messages.list_messages()

    PubSub.subscribe(MultiChat.PubSub, @topic)

    {:ok, assign(socket, messages: messages, current_user: user)}
  end

  def render(assigns) do
    # return /templates/page/index.html.leex
    MultiChatWeb.PageView.render("index.html", assigns)
  end

  def handle_event("send_msg", %{"msg" => msg}, socket) do
    msg
    |> String.trim()
    |> case do
      "" ->
        {:noreply, socket}
      msg ->
        new_msg = Messages.create_message(socket.assigns.current_user, msg)

        PubSub.broadcast(MultiChat.PubSub, @topic, %{event: "new_msg", body: new_msg})

        {:noreply, assign(socket, messages: [new_msg | socket.assigns.messages])}
    end
  end

  def handle_event("delete_msg", %{"msg_id" => msg_id}, socket) do
    msg_id
    |> Messages.get_message_by_id()
    |> Messages.delete_message()

    PubSub.broadcast(MultiChat.PubSub, @topic, %{event: "delete_msg", body: msg_id})

    {:noreply, assign(socket, messages: Enum.reject(socket.assigns.messages, &(&1.message_id == msg_id)))}
  end

  def handle_info(%{event: "new_msg", body: _msg}, socket) do
    {:noreply, assign(socket, messages: Messages.list_messages())}
  end

  def handle_info(%{event: "delete_msg", body: _msg_id}, socket) do
    {:noreply, assign(socket, messages: Messages.list_messages())}
  end
end
