defmodule Rentapay.Router.Host do
  import Rentapay.Transform
  import Rentapay.Seeds
  use Maru.Router
  namespace :host do

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
      params do
        requires :street
        requires :house
        requires :floor, type: Integer
        requires :flat_number, type: Integer, source: "flatNumber"
        requires :description
        requires :rooms, type: Integer, values: 1..10
        requires :price, type: Integer
        requires :minimal_rent_months, type: Integer, source: "minimalRentMonths"

        requires :supposed_start_date, type: String, source: "supposedStartDate"
        requires :credit_payment_enabled, type: Boolean, default: false, source: "creditPaymentEnabled"
      end
      post do
        attrs = struct(Rentapay.Entity.Rent, Map.merge(params, %{owner_id: host_id()}))
        {:ok, data} = Rentapay.Repo.insert(attrs)
        response = data |> Rentapay.Entity.RentSerializer.serialize |> camelize_keys
        json(conn, response)
      end
    end

    namespace :previews do
      get do
        previews = Rentapay.Repo.all(Rentapay.Entity.Preview)
        response = Rentapay.Entity.PreviewSerializer.serialize(previews)
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
          requires :state, type: String, values: ["rejected", "accepted"]
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
      params do
        requires :started_at, source: "startedAt"
        requires :expires_at, source: "expiresAt"
        requires :price, type: Integer
        requires :credit_payment_enabled, type: Boolean, default: false, source: "creditPaymentEnabled"
        requires :smoking_allowed, type: Boolean, source: "smokingAllowed"
        requires :pets_allowed, type: Boolean, source: "petsAllowed"
        requires :guests_allowed, type: Boolean, source: "guestsAllowed"
        requires :night_party_allowed, type: Boolean, source: "nightPartyAllowed"
        requires :contragent_id, type: Integer, source: "contragentId"
        requires :rent_id, type: Integer, source: "rentId"
      end
      post do
        attrs = struct(Rentapay.Entity.Contract, Map.merge(params, %{state: "pending"}))
        {:ok, data} = Rentapay.Repo.insert(attrs)
        response = data |> Rentapay.Entity.ContractSerializer.serialize |> camelize_keys
        json(conn, response)
      end
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
