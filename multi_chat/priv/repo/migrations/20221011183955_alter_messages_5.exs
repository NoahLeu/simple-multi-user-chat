defmodule MultiChat.Repo.Migrations.AlterMessages5 do
  use Ecto.Migration

  def change do
    drop table(:messages)

    # create new messages
    create table(:messages) do
      add :message_id, :string
      add :body, :string
      add :sent_at, :naive_datetime
      add :user_id, :string
      add :user_email, :string

      timestamps()
    end

    create unique_index(:messages, [:message_id])

  end
end
