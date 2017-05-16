defmodule Rentapay.Router.System do
  use Maru.Router
  namespace :seeds do
    delete do
      {deleted_previews, nil} = Rentapay.Repo.delete_all(Rentapay.Entity.Preview)
      {deleted_contracts, nil} = Rentapay.Repo.delete_all(Rentapay.Entity.Contract)
      json(conn, %{result: "ok", objectsDeleted: %{previews: deleted_previews, contracts: deleted_contracts}})
    end
  end
end
