defmodule MultiChat.Repo.Migrations.AlterMessages2 do
  use Ecto.Migration

  alias MultiChat.Accounts.User

  def change do
    drop table(:messages)

    # create new messages
    create table(:messages) do
      add :message_id, :string
      add :body, :string
      add :belongs_to, :string
      add :sent_at, :naive_datetime

      timestamps()
    end

    create unique_index(:messages, [:message_id])
  end
end
