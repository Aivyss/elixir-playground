IO.puts "===anonymous function==="
sum = fn (a, b) -> a + b end
IO.puts "sum.(2, 3) = #{sum.(2, 3)}"

IO.puts "===named function==="
defmodule Math do
  def sum(a, b) do
    a + b
  end

  def pow(a, b), do: a ** b
end
IO.puts "Math.sum(3, 4) = #{Math.sum(3, 4)}"
IO.puts "Math.pow(3, 4) = #{Math.pow(2, 3)}"

defmodule Length do
  def of([]), do: 0
  def of([_ | tail]), do: 1 + of tail
  def of2(list) do
    case list do
      [] -> 0
      [_ | tail] -> 1 + of2 tail
    end
  end
end
IO.puts "Length.of([]) = #{Length.of([])}"
IO.puts "Length.of([1, 2, 3]) = #{Length.of([1, 2, 3])}"
IO.puts "Length.of2([]) = #{Length.of2 []}"
IO.puts "Length.of2([1, 2, 3]) = #{Length.of2 [1, 2, 3]}"

IO.puts "===function pattern matching==="
defmodule Person do
  # pattern matchingを使用して、deconstructionを行うことも可能であり、元の値を変数としてもらうことも可能
  def name(%{name: name} = person) do
    "person.name: #{person[:name]}, person.age: #{person[:age]}, name: #{name}"
  end
  def age(%{age: age} = person) do
    "#{person(person)}, age: #{age}"
  end
  defp person(%{name: name, age: age}) do
    # defpはprivateな関数であり、defmoduleの内部でしか呼び出せない
    "person.name: #{name}, person.age: #{age}"
  end
end
james = %{name: "James", age: 20}
IO.puts "Person.name(james) = #{Person.name james}"
IO.puts "Person.age(james) = #{Person.age james}"

IO.puts "===function guards==="
defmodule CustomMath do
  def sum(nums) when is_list(nums) do # sum1
    Enum.reduce nums, &(&1 + &2)
  end
  def sum(num) when is_integer(num) do # sum2
    num
  end
end
IO.puts "CustomMath.sum([1, 2, 3]) = #{CustomMath.sum [1, 2, 3] }" # sum1
IO.puts "CustomMath.sum(3) = #{CustomMath.sum 3}" # sum2

IO.puts "===default arguments==="
defmodule CustomMap do
  def map(list, fun, n\\1) do
    Enum.map_every(list, n, fun)
  end
end
CustomMap.map([1, 2, 3, 4, 5], &(&1 * 2)) |> IO.inspect # expected: [2, 4, 6, 8, 10]
