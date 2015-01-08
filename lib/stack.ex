defmodule Stack do
  use GenServer

  # Client API
  def start_link(id, default \\ []) do
    GenServer.start_link(__MODULE__, default, name: {:via, Stack.Registry, id})
  end

  def push(id, item) do
    GenServer.call({:via, Stack.Registry, id}, {:push, item})
  end

  def pop(id) do
    GenServer.call({:via, Stack.Registry, id}, :pop)
  end

  # Server Callbacks
  def handle_call(:pop, _from, [h|t]) do
    {:reply, h, t}
  end

  def handle_call(msg, from, state) do
    super(msg, from, state)
  end

  def handle_call({:push, item}, state) do
    {:reply, :ok, [item|state]}
  end

  def handle_cast(msg, state) do
    super(msg, state)
  end

  def handle_info(msg, state) do
    super(msg, state)
  end
end
