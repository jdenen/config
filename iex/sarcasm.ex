defmodule Sarcastic do
  def to_sarcasm(str) do
    make_sarcastic(str)
  end

  defp make_sarcastic(str) do
    case rando() do
      n when n < 3 -> sarcasm(str, n, :lower)
      n -> sarcasm(str, n, :upper)
    end
  end

  defp sarcasm(str, 0, :lower), do: sarcasm(str, rando(), :upper)
  defp sarcasm(str, 0, :upper), do: sarcasm(str, rando(), :lower)

  defp sarcasm(<<c>> <> str, n, letter_case) do
    <<set_case(c, letter_case)>> <> sarcasm(str, n - 1, letter_case)
  end

  defp sarcasm(_empty_str, _, _), do: ""

  defp set_case(char, :upper) when char in ?a..?z do
    char - 32
  end

  defp set_case(char, :lower) when char in ?A..?Z do
    char + 32
  end

  defp set_case(char, _), do: char

  defp rando do
    :rand.uniform(4)
  end
end
