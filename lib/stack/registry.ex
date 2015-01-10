defmodule Stack.Registry do
  use GenServer

  # Properties
  @self __MODULE__

  def start_link() do
    GenServer.start_link(@self, [], name: @self)
  end

  # Client Interface: #########################################################
  def register_name(name, pid) do
    GenServer.call(@self, {:register, name, pid})
  end

  def send(name, msg) do
    case GenServer.call(@self, {:where, name}) do
      :undefined ->
        {:badarg, {name, msg}}
      pid when is_pid(pid) ->
        GenServer.call(pid, msg)
    end
  end

  def unregister_name(name) do
    GenServer.call(@self, {:unregister, name})
  end

  def whereis_name(name) do
    GenServer.call(@self, {:where, name})
  end

  # Server Callbacks: #########################################################
  # Init
  def init([]) do
    {:ok, {%HashDict{}, %HashDict{}}}
  end

  # Handle Call {:where, name}
  def handle_call({:where, name}, _from, {names, _refs} = state) do
    case HashDict.fetch(names, name) do
      {:ok, pid} ->
        {:reply, pid, state}
      :error ->
        {:reply, :undefined, state}
    end
  end

  # Handle Call {:register, name}
  def handle_call({:register, name, pid}, _from, {names, refs} = state) do
    if HashDict.has_key?(names, name) do
      {:reply, :no, state}
    else
      refs = HashDict.put(refs, Process.monitor(pid), name)
      names = HashDict.put(names, name, pid)
      {:reply, :yes, {names, refs}}
    end
  end

  def handle_call({:unregister, name}, _from, {names, refs} = state) do

  end

  # Handle Call Generic
  def handle_call(msg, from, state) do
    super(msg, from, state)
  end

  # Handle Cast Generic
  def handle_cast(msg, state) do
    super(msg, state)
  end

  # Handle Info {:DOWN, ...}
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = HashDict.pop(refs, ref)
    names = HashDict.delete(names, name)
    {:noreply, {names, refs}}
  end

  # Handle Info Generic
  def handle_info(msg, state) do
    super(msg, state)
  end
end
