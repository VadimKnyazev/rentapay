defmodule Rentapay do
  @moduledoc """
  Documentation for Rentapay.
  """
  def start(_, _) do
    Rentapay.Supervisor.start_link
  end
  defmodule API do
    use Maru.Router
    plug CORSPlug, 
      methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"], 
      expose: ["Authorization", "Content-Type", "Accept", "Origin",
                    "User-Agent", "DNT","Cache-Control", "X-Mx-ReqToken",
                    "Keep-Alive", "X-Requested-With", "If-Modified-Since",
                    "X-CSRF-Token"],
      headers: ["Authorization", "Content-Type", "Accept", "Origin",
                    "User-Agent", "DNT","Cache-Control", "X-Mx-ReqToken",
                    "Keep-Alive", "X-Requested-With", "If-Modified-Since",
                    "X-CSRF-Token"]
    # headers: ["Authorization", "Content-Type", "Accept", "Origin",
    #             "User-Agent", "DNT","Cache-Control", "X-Mx-ReqToken",
    #                "Keep-Alive", "X-Requested-With", "If-Modified-Since",
    #                "X-CSRF-Token"], methods: "*", origin: "*"
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
