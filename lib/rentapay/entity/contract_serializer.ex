defmodule Rentapay.Entity.ContractSerializer do
  use Maru.Entity
  require Rentapay.Entity.UserSerializer
  expose :id
  expose :state
  expose :started_at
  expose :expired_at
  expose :price
  expose :credit_payment_enabled
  expose :smoking_allowed
  expose :pets_allowed
  expose :guests_allowed
  expose :night_party_allowed
  expose :state
  expose :contragent, [using: Rentapay.Entity.UserSerializer], fn(contract, _options) ->
    Rentapay.Repo.get(Rentapay.Entity.User, contract.contragent_id)
  end
  expose :rent, [using: Rentapay.Entity.RentSerializer], fn(contract, _options) ->
    Rentapay.Repo.get(Rentapay.Entity.Rent, contract.rent_id)
  end
end
