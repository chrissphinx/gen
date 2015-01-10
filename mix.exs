defmodule Gen.Mixfile do
  use Mix.Project

  def project do
    [app: :gen,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger],
     mod: {Gen, []}]
  end

  defp deps do
    []
  end
end
