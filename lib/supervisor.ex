defmodule Gen.Supervisor do
  use Supervisor

  @self __MODULE__
  @registry Stack.Registry
  @supervisor Stack.Supervisor

  def start_link() do
    Supervisor.start_link(@self, [], name: @self)
  end

  def init([]) do
    children = [
      supervisor(@supervisor, []),
      worker(@registry, [])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
