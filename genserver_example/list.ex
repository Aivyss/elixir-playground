defmodule CustomList do
  use GenServer

  # client
  def start_link(namespace, state \\ []) do
    GenServer.start_link(__MODULE__, state, name: namespace)
  end

  def add(pid, values) when is_pid(pid), do: add_p(pid, values)
  def add(namespace, values) when is_atom(namespace), do: add_p(namespace, values)
  defp add_p(v, values), do: GenServer.call(v, {:add, values})

  def list(pid) when is_pid(pid), do: list_p(pid)
  def list(namespace) when is_atom(namespace), do: list_p(namespace)
  defp list_p(v), do: GenServer.call(v, :list)

  def get(pid, idx) when is_pid(pid), do: get_p(pid, idx)
  def get(namespace, idx) when is_atom(namespace), do: get_p(namespace, idx)
  def get_p(v, idx), do: GenServer.call(v, {:get, idx})

  # server callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call({:add, values}, _from, state) when is_list(values) do
    {:reply, state ++ values, state ++ values}
  end

  def handle_call({:add, value}, _from, state) do
    {:reply, [value] ++ state, [value] ++ state}
  end

  def handle_call(:list, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:get, idx}, _from, state) do
    {:reply, Enum.at(state, idx), state}
  end
end

defmodule Runner1 do
  def run do
    {:ok, pid} = CustomList.start_link(__MODULE__, [])
    pid |> CustomList.add([1,2,3])
    pid |> CustomList.get(1) |> IO.inspect
    pid |> CustomList.list() |> IO.inspect
  end
end

defmodule Runner2 do
  def run do
    IO.puts "===PIDによりstate管理==="
    {:ok, pid} = CustomList.start_link(__MODULE__, [])
    pid |> CustomList.add([4,5,6])
    pid |> CustomList.get(1) |> IO.inspect
    pid |> CustomList.list() |> IO.inspect


    IO.puts "===名称によりstate管理==="
    {:ok, pid} = CustomList.start_link(:my_list, [])
    pid |> CustomList.add(["a", "b", "c"])
    :my_list |> CustomList.get(1) |> IO.inspect
    :my_list |> CustomList.list() |> IO.inspect
  end
end

Runner1.run
Runner2.run
