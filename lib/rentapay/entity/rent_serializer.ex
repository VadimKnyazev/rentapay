defmodule Rentapay.Entity.RentSerializer do
  use Maru.Entity
  expose :id
  expose :house
  expose :price
  expose :minimal_rent_months
  expose :credit_payment_enabled
  expose :supposed_start_date
  expose :description
  expose :owner, [using: Rentapay.Entity.UserSerializer], fn(rent, _options) ->
    Rentapay.Repo.get(Rentapay.Entity.User, rent.owner_id)
  end
end
