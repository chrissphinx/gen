defmodule Stack.Supervisor do
  use Supervisor

  @self __MODULE__

  def start_link() do
    Supervisor.start_link(@self, [], name: @self)
  end

  def init([]) do
    child_type = [worker(Stack, [], restart: :transient)]
    supervise(child_type, strategy: :simple_one_for_one)
  end
end
