defmodule Rentapay.Entity.Preview do
  use Ecto.Schema
  schema "previews" do
    field :state, :string
    belongs_to :contragent, Rentapay.Entity.User
    belongs_to :rent, Rentapay.Entity.Rent
    timestamps()
  end
end

