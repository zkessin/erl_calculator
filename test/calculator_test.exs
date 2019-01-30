defmodule CalculatorTest do
  use ExUnit.Case
  use PropCheck
  doctest Calculator

  test "Basic Lexing" do
    assert {:ok,
            [
              {:lparen, 1},
              {:number, 1, 12},
              {:mult, 1},
              {:number, 1, 4},
              {:rparen, 1}
            ], 1} = :lexer.string('(12 * 4)')
  end

  test "Calculate" do
    assert 24 == Calculator.calculate("6 * 4")
    assert 24 == Calculator.calculate("6 * (3 + 1)")
    assert 24 == Calculator.calculate("(12 * 4) / 2")
    assert 24 == Calculator.calculate("(12 * 4) / (3 - 1)")
    assert 24 == Calculator.calculate("(3 * 4 * 4) / (3 - 1)")
  end

  property "Calculate various equations" do
    forall exp <- expression() do
      {expected, _} = Code.eval_string(exp)
      assert expected == Calculator.calculate(exp)
    end
  end

  def operator() do
    oneof(["+", "-", "*"])
  end

  def expression() do
    let [number1 <- integer(), op <- operator(), number2 <- integer()] do
      :io_lib.format("~p ~s ~p", [number1, op, number2]) |> to_string()
    end
  end
end
