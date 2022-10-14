defmodule MultiChat.Repo.Migrations.AddMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string
      add :user_id, references(:users, on_delete: :delete_all)
      add :sent_at, :naive_datetime

      timestamps()
    end

  end
end
