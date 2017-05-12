defmodule Rentapay.Seeds do
  def host_id do
    Rentapay.Repo.get_by(Rentapay.Entity.User, login: "host@gmail.com").id
  end

  def tenant_id do
    Rentapay.Repo.get_by(Rentapay.Entity.User, login: "tenant@gmail.com").id
  end
end
