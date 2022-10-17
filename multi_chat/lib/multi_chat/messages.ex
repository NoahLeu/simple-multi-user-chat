defmodule MultiChat.Messages do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :message_id, :string
    field :body, :string
    field :sent_at, :naive_datetime
    field :user_id, :integer
    field :user_email, :string

    timestamps()
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message_id, :body, :user_id, :user_email, :sent_at])
    |> validate_required([:message_id, :body, :user_id, :user_email, :sent_at])
  end

  def create_message(user, body) do
    %MultiChat.Messages{}
    |> MultiChat.Messages.changeset(%{
      message_id: Ecto.UUID.generate(),
      body: body,
      user_id: user.id,
      user_email: user.email,
      sent_at: DateTime.utc_now()
    })
    |> MultiChat.Repo.insert!()
  end

  def create_message(attrs \\ %{}) do
    # generate unique id for message
    attrs = Map.put(attrs, :message_id, Ecto.UUID.generate())
    %MultiChat.Messages{}
    |> MultiChat.Messages.changeset(attrs)
    |> MultiChat.Repo.insert!()
  end

  def delete_message(message) do
    MultiChat.Repo.delete(message)
  end

  def get_message_by_id(message_id) do
    MultiChat.Repo.get_by(MultiChat.Messages, message_id: message_id)
  end

  def list_messages do
    # get all messages sorted by date with the most recent last
    all_messages = MultiChat.Repo.all(MultiChat.Messages)

    # date is in format: YYYY-MM-DDTHH:MM:SS
    # {:ok, date} = DateTime.from_iso8601(date_string)
    # convert message dates to DateTime as above
    messages_dates_converted = Enum.map(all_messages, fn message ->
      %{
        message_id: message.message_id,
        body: message.body,
        user_id: message.user_id,
        user_email: message.user_email,
        sent_at: DateTime.from_naive!(message.sent_at, "Etc/UTC")
      }
    end)

    # sort messages by date
    Enum.sort(messages_dates_converted, & DateTime.compare(&1.sent_at, &2.sent_at) != :gt)

    #!TODO: sort dates better without sort function (compare)
    # ? module calendar for formatting
  end
end
