defmodule Rentapay do
  @moduledoc """
  Documentation for Rentapay.
  """
  def start(_, _) do
    Rentapay.Supervisor.start_link
  end
  defmodule API do
    use Maru.Router
    plug CORSPlug 
    plug Plug.Logger
    plug Plug.Parsers,
      pass: ["*/*"],
      json_decoder: Poison,
      parsers: [:json]
    plug Rentapay.Middleware.JWT
    mount Rentapay.Router.Host
    mount Rentapay.Router.Tenant
    mount Rentapay.Router.System
    mount Rentapay.Router.Account
  end
end
