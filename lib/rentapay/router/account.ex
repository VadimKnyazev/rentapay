defmodule Rentapay.Router.Account do
  use Maru.Router
  import Comeonin.Pbkdf2
  alias Rentapay.Entity.User, as: User
  namespace :account do
    params do
      requires :login, regexp: ~r/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
      requires :password
      requires :first_name, source: "firstName"
      requires :last_name, source: "lastName"
    end
    post do
      sec_password = hashpwsalt(params[:password])
      attrs = %User{login: params[:login], secured_password: sec_password, 
                    first_name: params[:first_name], last_name: params[:last_name]}
      Rentapay.Repo.insert(attrs)
      json(conn, %{token: "OK"})
    end
    namespace :sessions do
      params do
        requires :login
        requires :password
      end
      post do
        user = Rentapay.Repo.get_by(User, login: params[:login])
        if user && checkpw(params[:password], user.secured_password) do
          json(conn, %{token: Rentapay.Token.generate(user)})
        else
          conn |> put_status(404) |> json(%{error: "Wrong username and password"})
        end
      end
    end
  end
end
