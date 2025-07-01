m1 = %{key1: "1", key2: "2"}

IO.puts "===Map.put==="
m2 = Map.put(m1, :key3, "3")

IO.puts "m1[:key1] = #{m1[:key1]}"
IO.puts "m1[:key2] = #{m1[:key2]}"
IO.puts "m1[:key3] = #{m1[:key3]}"

IO.puts "m2[:key1] = #{m2[:key1]}"
IO.puts "m2[:key2] = #{m2[:key2]}"
IO.puts "m2[:key3] = #{m2[:key3]}"

IO.puts "===%{x | key: value}==="
m3 = %{m1 | key2: "changed"}

IO.puts "m1[:key1] = #{m1[:key1]}"
IO.puts "m1[:key2] = #{m1[:key2]}"
IO.puts "m1[:key3] = #{m1[:key3]}"

IO.puts "m3[:key1] = #{m3[:key1]}"
IO.puts "m3[:key2] = #{m3[:key2]}"
IO.puts "m3[:key3] = #{m3[:key3]}"
