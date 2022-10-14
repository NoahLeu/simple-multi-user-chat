defmodule MultiChat.Repo.Migrations.AlterMessages do
  use Ecto.Migration

  def change do
    # drop old messages
    drop table(:messages)

    # create new messages
    create table(:messages) do
      add :message_id, :string
      add :body, :string
      add :user_id, references(:users, on_delete: :delete_all)
      add :sent_at, :naive_datetime

      timestamps()
    end

    create unique_index(:messages, [:message_id])
  end
end
