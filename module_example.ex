IO.puts "===nested modules==="
defmodule Utils do
  defmodule Math do
    def sum(a, b) when is_integer(a) and is_integer(b), do: {:sum1, a + b}
    def sum({a, b}) when is_integer(a) and is_integer(b), do: {:sum2, a + b}
  end
end

{1, 2} |> Utils.Math.sum |> IO.inspect
Utils.Math.sum(3, 5) |> IO.inspect

IO.puts "===module attributes==="
# @moduledoc moduleの説明をする
# @doc 関数とマクロを説明する
# @behaviour OTPまたはユーザが定義した振る舞い(ビヘイビア)
defmodule Constants do
  @pi 3.14

  def pi, do: @pi
end

IO.puts "Constants.pi = #{Constants.pi}"

IO.puts "===structures==="
defmodule ExampleStructs.Person do
  alias ExampleStructs.Person
  # zero valueの定義が構造体の定義時にできる
  # @deriveにて出力するmemberを制限することができる
  @derive {Inspect, only: [:name, :gender]}
  defstruct name: "steve", age: 0, gender: :none

  def new(), do: %Person{}
  def new(name, age, gender) do
    case {name, age, gender} do
      {name, age, gender} when is_binary(name) and is_integer(age) and is_atom(gender) ->
        %Person{name: name, age: age, gender: gender}
      {name, age, _} when is_binary(name) and is_integer(age) ->
        %Person{name: name, age: age}
      {name, _, gender} when is_binary(name) and is_atom(gender) ->
        %Person{name: name, gender: gender}
      {_, age, gender} when is_integer(age) and is_atom(gender) ->
        %Person{age: age, gender: gender}
      {name, _, _} when is_binary(name) ->
        %Person{name: name}
      {_, age, _} when is_integer(age) ->
        %Person{age: age}
      {_, _, gender} when is_atom(gender) ->
        %Person{gender: gender}
        _ -> new()
    end
  end


  # compile problem
  ## error: cannot access struct ExampleStructs.Person, the struct was not yet defined or the struct is being accessed in the same context that defines it
  ## elixir compilerの特徴により、defmoduleの外からは使え無さそう。
  ### Scanning -> Parsing -> Expansion <-> Translation <-> Execution
  ## この問題を解決するためにはコンストラクタ関数を用意して、必ずコンストラクタ経由で構造体を生成すれば回避できる。

  # その他
  ## elixirにはimportキーワードが存在するが、javaやgoみたいな動きをしてはない。javascriptみたいに全てのコードを１ファイルにするような感じ
end

defmodule StructExampleMain do
  def run() do
    %ExampleStructs.Person{} |> IO.inspect # create default struct

    alice = %ExampleStructs.Person{name: "alice", age: 13, gender: :female} # create struct
    IO.inspect alice

    mike = %{alice | name: "mike", gender: :male} # replace+create struct member
    IO.inspect mike

    %{name: name, gender: :female} = alice # pattern matching
    IO.puts "pattern matching name=#{name}"
  end
end

StructExampleMain.run()

# コンストラクタを定義することでdefmoduleの外からも使えるように回避する
ExampleStructs.Person.new("jobs1", 23, :male) |> IO.inspect
ExampleStructs.Person.new("jobs2", nil, nil) |> IO.inspect
ExampleStructs.Person.new("jobs3", nil, :male) |> IO.inspect
ExampleStructs.Person.new(nil, nil, nil) |> IO.inspect

defmodule Test2 do
  defstruct name: "steve", age: 0
end
