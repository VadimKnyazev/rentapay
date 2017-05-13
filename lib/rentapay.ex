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
    #after do
      #end
    plug Plug.Logger
    plug Plug.Parsers,
      pass: ["*/*"],
      json_decoder: Poison,
      parsers: [:json]
    mount Rentapay.Router.Host
    mount Rentapay.Router.Tenant
  end
end
