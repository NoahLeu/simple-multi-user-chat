defmodule MultiChat.Repo.Migrations.AlterMessages4 do
  use Ecto.Migration

  def change do

    drop table(:messages)

    # create new messages
    create table(:messages) do
      add :message_id, :string
      add :body, :string
      add :owner, references(:users, on_delete: :delete_all)
      add :sent_at, :naive_datetime

      timestamps()
    end

    create unique_index(:messages, [:message_id])
  end
end
