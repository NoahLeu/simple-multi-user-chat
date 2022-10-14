defmodule MultiChatWeb.CustomSocket do
  use Phoenix.Socket

  channel "room:message_updates", MultiChatWeb.RoomChannel

  def connect(_params, socket) do
    _params
    |> IO.inspect(label: "params")
    {:ok, socket}
  end

  def id(_socket), do: nil
end
