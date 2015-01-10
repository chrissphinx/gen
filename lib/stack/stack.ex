defmodule Stack do
  use GenServer

  @self __MODULE__
  @registry Stack.Registry
  @supervisor Stack.Supervisor

  def start_link(name, default \\ []) do
    GenServer.start_link(@self, default, name: {:via, @registry, name})
  end

  # Client Interface
  def create(name, default \\ []) do
    Supervisor.start_child(@supervisor, [name, default])
  end

  def push(name, item) do
    GenServer.call({:via, @registry, name}, {:push, item})
  end

  def pop(name) do
    GenServer.call({:via, @registry, name}, :pop)
  end

  def destroy(name) do
    GenServer.call({:via, @registry, name}, :stop)
  end

  # Server Callbacks
  def handle_call(:pop, _from, [h|t]) do
    {:reply, h, t}
  end

  def handle_call({:push, item}, _from, state) do
    {:reply, :ok, [item|state]}
  end

  def handle_call(:stop, _from, state) do
    {:stop, :normal, :ok, state}
  end

  # Default Callbacks
  def handle_call(msg, from, state) do
    super(msg, from, state)
  end

  def handle_cast(msg, state) do
    super(msg, state)
  end

  def handle_info(msg, state) do
    super(msg, state)
  end
end
