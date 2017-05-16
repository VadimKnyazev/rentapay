defmodule Rentapay.Router.Host do
  import Rentapay.Transform
  import Rentapay.Seeds
  import Rentapay.JSON
  #import Rentapay.Session
  alias Rentapay.Entity, as: E
  alias Rentapay.DS.Host, as: DS
  use Maru.Router
  namespace :host do
    namespace :rents do
      get do
        current_user = conn.private.current_user
        response = DS.rents(current_user["id"]) |> serialize 
        json(conn, response)
      end
      route_param :id, type: Integer do
        get do
          current_user = conn.private.current_user
          json conn, DS.rent(current_user["id"], params[:id]) |> serialize
        end
      end
      params do
        requires :street
        requires :house
        requires :entrance, type: Integer
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
        current_user = conn.private.current_user
        attrs = struct(Rentapay.Entity.Rent, Map.merge(params, %{owner_id: current_user["id"]}))
        {:ok, data} = Rentapay.Repo.insert(attrs)
        response = serialize(data) 
        json(conn, response)
      end
    end

    namespace :previews do
      get do
        current_user = conn.private.current_user
        response = DS.previews(current_user["id"]) |> serialize
        json(conn, response)
      end

      route_param :id, type: Integer do
        get do
          current_user = conn.private.current_user
          response = DS.preview(current_user["id"], params[:id]) |> serialize
          json(conn, response)
        end
        params do
          requires :state, type: String, values: ["rejected", "accepted"]
        end
        patch do
          current_user = conn.private.current_user
          {:ok, result} = DS.preview(current_user["id"], params[:id]) 
                          |> Ecto.Changeset.change(state: params[:state])
                          |> Rentapay.Repo.update
          json(conn, serialize(result))          
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
        current_user = conn.private.current_user
        attrs = struct(Rentapay.Entity.Contract, Map.merge(params, %{state: "pending"}))
        {:ok, data} = Rentapay.Repo.insert(attrs)
        json(conn, serialize(data))
      end
      get do
        current_user = conn.private.current_user
        response = DS.contracts(current_user["id"]) |> serialize
        json(conn, response)
      end
      route_param :id, type: Integer do
        get do
          current_user = conn.private.current_user
          response = DS.contract(current_user["id"], params[:id]) |> serialize
          json(conn, response)
        end
      end
    end
  end
end
