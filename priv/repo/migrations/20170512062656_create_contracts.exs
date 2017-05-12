defmodule Rentapay.Repo.Migrations.CreateContracts do
  use Ecto.Migration

  def change do
    create table(:contracts) do
      add :started_at, :string
      add :expires_at, :string
      add :price, :integer
      add :credit_payment_enabled, :boolean
      add :smoking_allowed, :boolean
      add :pets_allowed, :boolean
      add :guests_allowed, :boolean
      add :night_party_allowed, :boolean
      add :state, :string
      add :rent_id, references(:rents), null: false
      add :contragent_id, references(:users), null: false
    end
  end
end
