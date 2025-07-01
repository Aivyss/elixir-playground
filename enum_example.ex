IO.puts "===Enum.all?/2==="
Enum.all?(["apple", "banana", "kiwi"], fn s -> String.length(s) == 5 end) |> IO.puts

IO.puts "===Enum.any?/2==="
IO.puts Enum.any?(["apple", "banana", "kiwi"], fn s -> String.length(s) == 5 end) |> IO.puts

IO.puts "===Enum.chunk_every/2, Enum.each/2==="
Enum.chunk_every([1,2,3, 4,5,6, 7,8], 3) |> Enum.each(fn x -> IO.puts inspect(x, charlists: :as_list) end)

IO.puts "===Enum.map/2==="
Enum.map([1, 2, 3], &(&1 * 2)) |> IO.inspect

IO.puts "===Enum.min/1 and Enum.max/1==="
Enum.min([1, 2, 3]) |> IO.puts
Enum.max([1, 2, 3]) |> IO.puts

IO.puts "===Enum.min/2 and Enum.max/2==="
Enum.min([], fn -> :not_determined end) |> IO.puts
Enum.max([], fn -> :not_determined end) |> IO.puts
