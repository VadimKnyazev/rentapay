defmodule Rentapay.Entity.PreviewSerializer do
  use Maru.Entity
  expose :id
  expose :state
  expose :contragent, [using: Rentapay.Entity.UserSerializer], fn(preview, _options) ->
    Rentapay.Repo.get(Rentapay.Entity.User, preview.contragent_id)
  end
  expose :rent, [using: Rentapay.Entity.RentSerializer], fn(preview, _options) ->
    Rentapay.Repo.get(Rentapay.Entity.Rent, preview.rent_id)
  end
  expose :started, source: :inserted_at
end
