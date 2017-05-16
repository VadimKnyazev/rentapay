defmodule Rentapay.Repo.Migrations.CreateRents do
  use Ecto.Migration

  def change do
    create table(:rents) do
      add :street, :string
      add :house, :string, size: 20
      add :entrance, :integer
      add :floor, :integer
      add :flat_number, :integer
      add :rooms, :integer
      add :price, :integer
      add :minimal_rent_months, :integer
      add :credit_payment_enabled, :boolean
      add :supposed_start_date, :string
      add :description, :text
      add :owner_id, references(:users), null: false
    end 
  end
end
