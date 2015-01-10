defmodule GenTest do
  use ExUnit.Case

  test "create stack" do
    assert elem(Stack.create(0), 0) == :ok
    assert Stack.destroy(0) == :ok
  end

  test "pop from stack" do
    assert elem(Stack.create(0, [1]), 0) == :ok
    assert Stack.pop(0) == 1
    assert Stack.destroy(0) == :ok
  end

  test "stack restart" do
    assert elem(Stack.create(0, [1]), 0) == :ok
    assert Stack.pop(0) == 1
    catch_exit Stack.pop(0)
    :timer.sleep 1
    assert Stack.pop(0) == 1
    assert Stack.destroy(0) == :ok
  end

  test "push to stack" do
    assert elem(Stack.create(0, []), 0) == :ok
    assert Stack.push(0, 1) == :ok
    assert Stack.pop(0) == 1
    assert Stack.destroy(0) == :ok
  end
end
