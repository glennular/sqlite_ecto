defmodule Sqlite.Ecto.Mixfile do
  use Mix.Project

  def project do
    [app: :sqlite_ecto,
     version: "0.1.0",
     name: "Sqlite.Ecto",
     elixir: "~> 1.0",
     deps: deps,

     # testing
     test_paths: test_paths(Mix.env),
     aliases: ["test.all": &test_all/1,
               "test.integration": &test_integration/1],
     preferred_cli_env: ["test.all": :test],

     # hex
     description: description,
     package: package,

     # docs
     docs: [main: Sqlite.Ecto]]
  end

  # Configuration for the OTP application
  def application do
    [applications: [:logger]]
  end

  # Dependencies
  defp deps do
    [{:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.7", only: :dev},
     {:ecto, "~> 0.11"},
     {:sqlitex, "~> 0.4"}]
  end

  defp description, do: "SQLite3 adapter for Ecto"

  defp package do
    [contributors: ["Jason M Barnes"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/jazzyb/sqlite_ecto"}]
  end

  defp test_paths(:integration), do: ["integration"]
  defp test_paths(_), do: ["test"]

  defp test_integration(args) do
    args = if IO.ANSI.enabled?, do: ["--color" | args], else: ["--no-color" | args]
    System.cmd "mix", ["test" | args], into: IO.binstream(:stdio, :line),
                                       env: [{"MIX_ENV", "integration"}]
  end

  defp test_all(args) do
    Mix.Task.run "test", args
    test_integration(args)
  end
end
