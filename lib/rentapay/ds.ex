defmodule Rentapay.DS do
  import Ecto.Query
  import Rentapay.Repo
  alias Rentapay.Entity, as: E
  defmodule Host do
    def rents(host_id), do: with_owner(host_id) |> all
    def rent(host_id, rent_id), do: with_owner(host_id) |> get(rent_id)
    def previews(host_id), do: select_previews(host_id) |> all
    def preview(host_id, preview_id), do: select_previews(host_id) |> get(preview_id)
    def contracts(host_id), do: select_contracts(host_id) |> all
    def contract(host_id, contract_id), do: select_contracts(host_id) |> get(contract_id) 

    defp select_contracts(host_id) do
      ids = fetch_rent_ids(E.Rent, host_id)
      from c in E.Contract, where: c.rent_id in ^ids 
    end

    defp select_previews(host_id) do
      ids = fetch_rent_ids(E.Rent, host_id)
      from p in E.Preview, where: p.rent_id in ^ids 
    end

    defp with_owner(host_id), do: from r in E.Rent, where: r.owner_id == ^host_id
    defp fetch_rent_ids(query, host_id) do
      query = from r in with_owner(host_id), select: r.id 
      all query
    end
  end
end
