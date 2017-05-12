defmodule Rentapay.Entity.User do
  use Ecto.Schema

  schema "users" do
    field :login, :string
    field :first_name, :string
    field :last_name, :string
  end
end
