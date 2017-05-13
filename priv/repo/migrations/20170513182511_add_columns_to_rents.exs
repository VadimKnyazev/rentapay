defmodule Rentapay.Repo.Migrations.AddColumnsToRents do
  use Ecto.Migration

  def change do
    alter table(:rents) do
      add :rooms, :integer
      add :floor, :integer
      add :flat_number, :integer
    end
  end
end
