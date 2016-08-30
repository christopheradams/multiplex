defmodule Multiplex.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :multiplex,
     version: @version,
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     docs: [extras: ["README.md"]],
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:phoenix]]
  end

  defp deps do
    [{:phoenix, "~> 1.2.0"},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp description do
    """
    Phoenix router macro to dispatch multiple HTTP methods to a Plug
    """
  end

  defp package do
    [
     name: :multiplex,
     maintainers: ["Christopher Adams"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/christopheradams/multiplex"}
    ]
  end
end
