defmodule Stack.Supervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def create(id, default \\ []) do
    Supervisor.start_child(__MODULE__, [id, default])
  end

  def init([]) do
    child_type = [
      worker(Stack, [])
    ]
    supervise(child_type, strategy: :simple_one_for_one)
  end
end
