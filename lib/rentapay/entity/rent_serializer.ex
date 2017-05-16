defmodule Rentapay.Entity.RentSerializer do
  require Rentapay.Entity.UserSerializer 
  use Maru.Entity
  import Ecto.Query
  expose :id
  expose :street
  expose :house
  expose :entrance
  expose :floor
  expose :flat_number
  expose :rooms
  expose :price
  expose :minimal_rent_months
  expose :credit_payment_enabled
  expose :supposed_start_date
  expose :description
  expose :owner, [using: Rentapay.Entity.UserSerializer], fn(rent, _options) ->
    Rentapay.Repo.get(Rentapay.Entity.User, rent.owner_id)
  end
  expose :previews, [using: List[Rentapay.Entity.PreviewUnlinkedSerializer]], fn(rent, _options) ->
    id = rent.id
    query = 
      from p in Rentapay.Entity.Preview,
      where: p.rent_id == ^id
    Rentapay.Repo.all(query)
  end
end
