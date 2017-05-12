defmodule Rentapay.Entity.Contract do
  use Ecto.Schema
  schema "contracts" do
    field :started_at, :string
    field :expires_at, :string
    field :price, :integer
    field :credit_payment_enabled, :boolean
    field :smoking_allowed, :boolean
    field :pets_allowed, :boolean
    field :guests_allowed, :boolean
    field :night_party_allowed, :boolean
    field :state, :string
    belongs_to :contragent, Rentapay.Entity.User
    belongs_to :rent, Rentapay.Entity.Rent
  end
end
