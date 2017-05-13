defmodule Rentapay.Router.Tenant do
  import Rentapay.Transform
  import Rentapay.Seeds
  use Maru.Router
  namespace :tenant do
    namespace :rents do
      get do
        rents = Rentapay.Repo.all(Rentapay.Entity.Rent)
        response = Rentapay.Entity.RentSerializer.serialize(rents) |> camelize_keys
        json(conn, response)
      end
      route_param :id, type: Integer do
        get do
          rent = Rentapay.Repo.get(Rentapay.Entity.Rent, params[:id])
                 |> Rentapay.Entity.RentSerializer.serialize
                 |> camelize_keys
          json(conn, rent)
        end
      end
    end

    namespace :previews do
      params do
        requires :rent_id, type: Integer, source: "rentId"
      end
      post do
        attrs = %Rentapay.Entity.Preview{rent_id: params[:rent_id], contragent_id: tenant_id(), state: "pending"}
        {:ok, data} = Rentapay.Repo.insert(attrs)
        response = data |> Rentapay.Entity.PreviewSerializer.serialize |> camelize_keys
        json(conn, response)
      end
      get do
        previews = Rentapay.Repo.all(Rentapay.Entity.Preview)
        response = Rentapay.Entity.PreviewSerializer.serialize(previews)
                   |> camelize_keys
        json(conn, response)
      end
      route_param :id, type: Integer do
        get do
          preview = Rentapay.Repo.get(Rentapay.Entity.Preview, params[:id])
                    |> Rentapay.Entity.PreviewSerializer.serialize
                    |> camelize_keys
          json(conn, preview)
        end
        params do
          requires :state, type: String, values: ["canceled"]
        end
        patch do
          {:ok, result} = Rentapay.Repo.get(Rentapay.Entity.Preview, params[:id])
                          |> Ecto.Changeset.change(state: params[:state])
                          |> Rentapay.Repo.update
          response = result
                     |> Rentapay.Entity.PreviewSerializer.serialize
                     |> camelize_keys
          json(conn, response)          
        end
      end
    end

    namespace :contracts do
      get do
        contracts = Rentapay.Repo.all(Rentapay.Entity.Contract)
        response = Rentapay.Entity.ContractSerializer.serialize(contracts)
                   |> camelize_keys
        json(conn, response)
      end
      route_param :id, type: Integer do
        get do
          contract = Rentapay.Repo.get(Rentapay.Entity.Contract, params[:id])
                     |> Rentapay.Entity.ContractSerializer.serialize
                     |> camelize_keys
          json(conn, contract)
        end
      end
    end
  end
end
