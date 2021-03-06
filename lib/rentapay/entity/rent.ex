defmodule Rentapay.Entity.Rent do
  use Ecto.Schema

  schema "rents" do
    field :street, :string
    field :house, :string
    field :entrance, :integer
    field :floor, :integer
    field :flat_number, :integer
    field :rooms, :integer
    field :price, :integer
    field :minimal_rent_months, :integer
    field :credit_payment_enabled, :boolean
    field :supposed_start_date, :string
    field :description, :string
    belongs_to :owner, Rentapay.Entity.User
  end
end
