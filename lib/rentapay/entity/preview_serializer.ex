defmodule Rentapay.Entity.PreviewSerializer do
  require Rentapay.Entity.UserSerializer
  use Maru.Entity
  expose :id
  expose :state
  expose :contragent, [using: Rentapay.Entity.UserSerializer], fn(preview, _options) ->
    Rentapay.Repo.get(Rentapay.Entity.User, preview.contragent_id)
  end
  expose :rent, [using: Rentapay.Entity.RentUnlinkedSerializer], fn(preview, _options) ->
    Rentapay.Repo.get(Rentapay.Entity.Rent, preview.rent_id)
  end
  expose :started, source: :inserted_at
end
