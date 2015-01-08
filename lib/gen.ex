defmodule Gen do
  use Application

  def start(_type, _args) do
    Stack.Supervisor.start_link
    Stack.Registry.start_link
  end
end
