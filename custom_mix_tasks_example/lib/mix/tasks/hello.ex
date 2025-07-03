defmodule Mix.Tasks.Hello do
  @moduledoc """
  The hello mix task: `mix help hello`
  """
  use Mix.Task

  @shortdoc "Simply runs the CustomMixTasksExample.say/0 function"
  def run(_) do
    Mix.Task.run("app.start") # run application for dependencies

    CustomMixTasksExample.say()
  end
end

defmodule Mix.Tasks.Today do
  @moduledoc """
  The today mix task: `mix help today`
  """
  use Mix.Task

  @shortdoc "Prints the current date"
  def run(_) do
    Mix.Task.run("app.start") # run application for dependencies

    IO.puts DateTime.utc_now() |> Calendar.strftime("%Y-%m-%d")
  end
end
