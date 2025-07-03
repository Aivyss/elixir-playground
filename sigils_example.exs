# 大文字：エスケープや埋め込みを含まない
# 小文字：エスケープや埋め込みを含む
IO.puts "===~c and ~C (Char List sigils)==="
~c/ 2 + 7 = #{2 + 7}/ |> IO.puts
~C/ 2 + 7 = #{2 + 7} / |> IO.puts
## char listㅋはerlangとの互換性のため、存在する。elxirは普段stringを使う。
(~c/test/ != "test") |> IO.puts


IO.puts "=== ~r and ~R (Regular Expression sigils)==="
regex = ~r/elixir/

("elixir" =~ regex) |> IO.puts
("Elixir" =~ regex) |> IO.puts

regex_ignore_case = ~r/elixir/i
("elixir" =~ regex_ignore_case) |> IO.puts
("Elixir" =~ regex_ignore_case) |> IO.puts

IO.puts "===Regex API==="
Regex.split(~r/_/, "100_000_000") |> IO.inspect

IO.puts "===~w and ~W (word list sigils)==="
~w/foo bar baz/ |> IO.inspect

IO.puts "===make custom sigils==="
defmodule MySigils do
  def sigil_d(string, []) do
    now = DateTime.utc_now() |> Calendar.strftime("%Y-%m-%dT%H:%M:%S")
    string <> "_#{now}"
  end
end

defmodule SigilsMain do
  import MySigils

  def run() do
    ~d/hello/ |> IO.puts
  end
end
SigilsMain.run()
