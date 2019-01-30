defmodule Calculator do
  @moduledoc """
  Documentation for Calculator.
  """

  def calculate(string) do
    {:ok, tokens, _line} = to_charlist(string) |> :lexer.string()

    {:ok, exp} = :parser.parse(tokens)
    IO.inspect(exp, label: "Tree")
    calculate_inner(exp)
  end

  defp calculate_inner({:number, a}) do
    a
  end

  defp calculate_inner({:add, a, b}) do
    calculate_inner(a) + calculate_inner(b)
  end

  defp calculate_inner({:subtr, a, b}) do
    calculate_inner(a) - calculate_inner(b)
  end

  defp calculate_inner({:mult, a, b}) do
    calculate_inner(a) * calculate_inner(b)
  end

  defp calculate_inner({:divd, a, 0}) do
    exit(:devide_by_zero)
  end

  defp calculate_inner({:divd, a, b}) do
    calculate_inner(a) / calculate_inner(b)
  end
end
