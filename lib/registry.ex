defmodule Stack.Registry do
  use GenServer

  # Client API
  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def whereis_name(name) do
    GenServer.call(__MODULE__, {:lookup, name})
  end

  def register_name(name, pid) do
    GenServer.call(__MODULE__, {:create, name, pid})
  end

  def unregister_name(name) do
    
  end

  def send(name, msg) do
    
  end

  # Server Callbacks
  def init([]) do
    {:ok, %HashDict{}}
  end

  def handle_call({:lookup, name}, _from, names) do
    case HashDict.fetch(names, name) do
      {:ok, pid} ->
        {:reply, pid, names}
      :error ->
        {:reply, :undefined, names}
    end
  end

  def handle_call({:create, name, pid}, _from, names) do
    if HashDict.has_key?(names, name) do
      {:reply, :no, names}
    else
      {:reply, :yes, HashDict.put(names, name, pid)}
    end
  end
end
