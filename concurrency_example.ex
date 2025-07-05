IO.puts "===spawn==="
defmodule ConcurrencyExample do
  def add do
    receive do
      [a, b] ->
        if is_integer(a) and is_integer(b) do
          IO.puts "#{a} + #{b} = #{a + b}"
        else
          IO.puts "invalid arguments"
        end
      _ ->
        IO.puts "invalid arguments"
    end

    add() # PIDを再利用するため、わざと無限ループさせた
  end
end
spawn(ConcurrencyExample, :add, [])

IO.puts "===send message==="
pid = spawn(ConcurrencyExample, :add, []) |> IO.inspect
send pid, [] # invalid arguments
send pid, {1, 2} # invalid arguments
send pid, [1, 2] # 1 + 2 = 3
:timer.sleep(1000)

IO.puts "===spawn link==="
defmodule ConcurrencyExample2 do
  def explode, do: exit(:kaboooom)

  @doc """
  プロセス終了を受信してハンドリングする
  """
  def run do
    Process.flag(:trap_exit, true)
    spawn_link(ConcurrencyExample2, :explode, []) |> IO.inspect # プロセスの終了を受信することができる

    receive do
      {:EXIT, from_pid, reason} ->
        IO.puts "Process #{inspect from_pid} exited with reason #{inspect reason}"
    end
  end
end

# spawn(ConcurrencyExample2, :explode, []) |> IO.inspect # プロセスが終了されたかがわからない
# spawn_link(ConcurrencyExample2, :explode, []) |> IO.inspect # プロセスの終了を受信することができる

ConcurrencyExample2.run()

IO.puts "===process monitoring==="
defmodule ConcurrencyExample3 do
  def explode, do: exit(:kaboooom)

  @doc """
  非同期プロセスと連携したくはないが、そこからの情報は受け取りたい場合spawn_monitorを使う
  """
  def run do
    spawn_monitor(ConcurrencyExample3, :explode, [])

    receive do
      {:DOWN, ref, :process, from_pid, reason} ->
        IO.puts "process #{inspect from_pid} exited with reason #{inspect reason}, ref=#{inspect ref}"
    end
  end
end

ConcurrencyExample3.run
