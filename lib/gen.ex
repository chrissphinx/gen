defmodule Gen do
  use Application

  def start(_type, _args) do
    Gen.Supervisor.start_link
  end
end
