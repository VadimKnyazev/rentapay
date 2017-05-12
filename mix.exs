defmodule Rentapay.Mixfile do
  use Mix.Project

  def project do
    [app: :rentapay,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [ mod: {Rentapay, []},
      extra_applications: [:logger],
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
   [
     {:maru, "~> 0.11"},
     {:maru_entity, "~> 0.2.0"},
     {:eye_drops, "~> 1.3"},
     {:postgrex, ">= 0.0.0"},
     {:ecto, "~> 2.1"},
     {:inflex, "~> 1.7.0" },
     {:seedex, "~> 0.1.2"}
   ]
  end
end