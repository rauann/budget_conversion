defmodule ConversionTest do
  use ExUnit.Case

  test "private convert function" do
    amount = 10

    rates = %{
      "rates" => %{
        "TWD" => 35.533343,
        "TZS" => 2718.352462,
        "UAH" => 31.275984,
        "UGX" => 4429.420661,
        "USD" => 1.19488
      }
    }

    expected = amount / rates["rates"]["USD"]

    assert Budget.Conversion.convert({:ok, rates}, amount) == expected
  end
end
