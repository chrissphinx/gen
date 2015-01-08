defmodule GenTest do
  use ExUnit.Case

  test "create stack" do
    assert elem(Stack.Supervisor.create(0), 0) == :ok
  end

  test "pop from stack" do
    assert elem(Stack.Supervisor.create(1, [1]), 0) == :ok
    assert Stack.pop(1) == 1
  end

  test "stack restart" do
    assert elem(Stack.Supervisor.create(2, [1]), 0) == :ok
    assert Stack.pop(2) == 1
    assert catch_exit(Stack.pop(2))
    Task.await(Task.async(fn -> Stream.timer(500) |> Enum.to_list end), 5000)
    assert Stack.pop(2) == 1
  end
end
