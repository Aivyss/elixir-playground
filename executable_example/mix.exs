defmodule ExecutableExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :executable_example,
      version: "0.1.0",
      elixir: "~> 1.18",
      escript: escript(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp escript do
    [main_module: ExecutableExample.CLI]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
