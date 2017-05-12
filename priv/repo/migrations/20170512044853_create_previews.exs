defmodule Rentapay.Repo.Migrations.CreatePreviews do
  use Ecto.Migration

  def change do
    create table(:previews) do
      add :state, :string
      add :rent_id, references(:rents), null: false
      add :contragent_id, references(:users), null: false
      timestamps()
    end
  end
end
