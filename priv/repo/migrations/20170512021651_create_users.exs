defmodule Rentapay.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string, size: 100
      add :first_name, :string, size: 50
      add :last_name, :string, size: 50
    end
  end
end
