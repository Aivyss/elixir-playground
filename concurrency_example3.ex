Agent.start_link(fn -> [1, 2, 3] end, name: :my_agent)

defmodule ConcurrencyExample4 do
  def get_state(p \\ :get) do
    case p do
      :get ->
        IO.puts "start get state"
        :timer.sleep(1000)
        Agent.get(:my_agent, &(&1)) |> Enum.map(fn x -> x end)
      :double ->
        IO.puts "start double state"
        :timer.sleep(2000)
        Agent.get(:my_agent, &(&1)) |> Enum.map(fn x -> x * 2 end)
    end
  end
end


default_task = Task.async(ConcurrencyExample4, :get_state, [])
get_task = Task.async(ConcurrencyExample4, :get_state, [:get])
double_task = Task.async(ConcurrencyExample4, :get_state, [:double])

Task.await(default_task) |> IO.inspect
Task.await(get_task) |> IO.inspect
Agent.update(:my_agent, fn state -> state ++ [4, 5] end)
Task.await(double_task) |> IO.inspect
