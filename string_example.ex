IO.puts "===string.split/1==="
"apple banana kiwi" |> String.split |> IO.inspect # ["apple", "banana", "kiwi"]

IO.puts "===String.upcase/1==="
"English Korean Japanese" |> String.upcase |> IO.puts # ENGLISH KOREAN JAPANESE

IO.puts "===String.downcase/1==="
"ENGLISH KOREAN JAPANESE" |> String.downcase |> IO.puts # english korean japanese

IO.puts "===String.ends_with?/1==="
# pipeで関数を繋ぐ時にパラメータが２つ以上＋pipeから渡された値以外も使いたい場合、括弧を使うこと。（言語的には問題ないが、warningはする・曖昧になる）
# foo(1) |> bar(2) |> baz(3)
"apple" |> String.ends_with?("ple") |> IO.puts # true / String.ends_with?("apple", "ple")と同様
