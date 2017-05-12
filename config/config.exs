# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :maru, Rentapay.API,
  http: [port: 4080]

  #config :maru_entity, default_max_concurrency: 4 

config :rentapay, ecto_repos: [Rentapay.Repo]
config :rentapay, Rentapay.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "repay2",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432"

config :seedex,
  repo: Rentapay.Repo,
  seeds_path: "priv/repo"

  #config :eye_drops, 
  #tasks: [
  #  %{
  #    id: :web,
  #    name: "Web server",
  #    run_on_start: true,
  #    cmd: "mix run --no-halt",
  #    paths: ["lib/*", "config/*"]
  #  }
  #]
# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :rentapay, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:rentapay, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
