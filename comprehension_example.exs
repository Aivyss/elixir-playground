IO.puts "===simple list==="
for elem <- [1, 2, 3], do: IO.puts elem**elem

IO.puts "===keyword list==="
for {key, value} <- [a: 1, b: 2, c: 3], do: IO.puts "#{key}: #{value}"

IO.puts "===keyword list with pattern matching"
for {:true, v} <- [
  true: "elem1", # hit
  false: "elem2",
  true: "elem3", # hit
  true: "elem4", # hit
  false: "elem5"
], do: IO.puts "#{v}"

IO.puts "===map==="
for {key, value} <- %{a: 1, b: 2, c: 3}, do: IO.puts "#{key}: #{value}"

IO.puts "===nested generator==="
for e <- [1, 2, 3], ee <- 1..e do
  ee
end |> IO.inspect

IO.puts "===comprehension filters (like guards)"
# comprehension filterを複数適用することも可能である
list = [1, -2, 3, -4, 5, -6]
for e <- list, e > 0 do
  e
end |> IO.inspect # same as Enum.filter(list, &(&1 > 0))

IO.puts "===:into atom==="
# intoには Collectable protocolをimplementation指定るどの構造体でも可能
for {k, v} <- [a: 1, b: 2, c: 3, a: 4, b: 5], into: %{} do
  {k, v}
end |> IO.inspect
