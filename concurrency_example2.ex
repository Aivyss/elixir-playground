IO.puts "===agent==="
# Agent -> stateを持つbackground processを抽象化したもの
# Agentのstateは関数の戻り値である
{:ok, agent} = Agent.start_link(fn -> [1,2,3] end) |> IO.inspect()

Agent.update(agent, fn state ->
  IO.puts "before state: #{inspect state}"
  state ++ [4, 5]
end)

after_inspect = fn s -> IO.puts "inspect state: #{inspect s}" end
Agent.get(agent, &(&1)) |> after_inspect.()

IO.puts "===named agent==="
Agent.start_link(fn -> [4,5,6] end, name: :my_agent)
Agent.get(:my_agent, &(&1)) |> after_inspect.()
