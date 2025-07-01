IO.puts "===if/else==="
if String.valid?("hello") do
  IO.puts "valid"
else
  IO.puts "invalid"
end

if "hello" do
  IO.puts "truthy"
end

IO.puts "===case==="
tup = {:ok, "hello"}
case tup do
  {:ok, str} -> IO.puts str
  {:error} -> IO.puts "error"
  _ -> IO.puts "default" # caseでは何もマッチングしない場合、runtimeエラーを起こすため、`_ ->`のようなdefault条件を追加する
end

pie = 3.14
IO.puts "pie = #{pie}"
case "cherry pie" do
  ^pie -> IO.puts "pin operator: #{pie}"
  pie -> IO.puts "not pin operator: #{pie}"
  _ -> "dead code"
end

case 3.14 do
  ^pie -> IO.puts "pin operator: #{pie}" # `^pie = 3.14` match operator OK
  pie -> IO.puts "dead code: #{pie}" # `pie = 3.14` match operator OK、だが、上の条件が先にマッチングしてこの段階まではこない
  _ -> "dead code"
end

case 3.14 do
  3.141592 -> IO.puts "dead code"
  pie -> IO.puts "always match: #{pie}"
  ^pie -> IO.puts "dead code"
  _ -> "dead code"
end

IO.puts "===cond==="
cond do
  2 + 2 == 5 -> IO.puts "dead code"
  2 + 2 == 4 -> IO.puts "always match"
  true -> IO.puts "dead code" # condに何もマッチしてないとruntimeエラーを起こすため、elseみたいな感覚として `true ->`の条件を追加する
end

IO.puts "===control structureは戻り値をもつ==="
# if / case / condどちらもリターンを持つ関数みたいな扱いができる。これはkotlinと同様
if_result = if false do
  "dead code"
else
  "always match"
end
if_result |> (&("actual: #{&1}")).() |> IO.puts # expected: "always match"

case_result = case 3.14 do
  3.141592 -> "dead code"
  pie -> "always match: #{pie}"
  ^pie -> "dead code: #{pie}"
  _ -> "dead code"
end
case_result |> (fn (v) -> "actual: #{v}" end).() |> IO.puts # expected "always match: 3.14"

cond_result = cond do
  2 + 2 == 5 -> 0
  2 + 2 == 4 -> 1
  true -> -1
end
cond_result |> (fn (v) -> "actual: #{v}" end).() |> IO.puts # expected: 1
