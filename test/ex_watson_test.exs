defmodule ExWatsonTest do
  use ExUnit.Case
  doctest ExWatson

  test "greets the world" do
    assert ExWatson.hello() == :world
  end
end
