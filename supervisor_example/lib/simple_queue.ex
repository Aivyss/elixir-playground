defmodule SimpleQueue do
  use GenServer

  ### GenServerAPI

  @doc """
  Genserver.init/1 callback
  """
  def init(state), do: {:ok, state}

  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  @doc """
  GenServer.handle_cast/2 callback
  """
  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

  ### Client API / Helper functions
  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end # 同期プロセス

  # 同期はGenserver.call/2により、非同期はGenserver.cast/2により行われる
  # GenServer.callをhandlingするhandle_call/3を定義する必要がある
  # GenServer.castをhandlingするhandle_cast/2を定義する必要がある
  # GenServerを使うには back/front(=client)の実装が必要となる
  def queue, do: GenServer.call(__MODULE__, :queue) # 同期プロセス
  def dequeue, do: GenServer.call(__MODULE__, :dequeue) # 同期プロセス
  def enqueue(value), do: GenServer.cast(__MODULE__, {:enqueue, value}) # 非同期プロセス
end
