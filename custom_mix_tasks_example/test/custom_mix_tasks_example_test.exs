defmodule CustomMixTasksExampleTest do
  use ExUnit.Case
  doctest CustomMixTasksExample

  test "greets the world" do
    assert CustomMixTasksExample.hello() == :world
  end
end
