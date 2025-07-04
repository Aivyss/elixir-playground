defmodule ExecutableExampleTest do
  use ExUnit.Case
  doctest ExecutableExample

  test "greets the world" do
    assert ExecutableExample.hello() == :world
  end
end
