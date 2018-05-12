defmodule Budget.Conversion do
  require IEx

  def from_dollar_to_euro(amount) do
    url = "http://data.fixer.io/api/latest?access_key=#{System.get_env("FIXER_KEY")}"

    case HTTPoison.get(url) do
      {:ok, response} -> parse(response) |> convert(amount)
      {:error, _} -> "Error fetching rates"
    end
  end

  defp parse(%{status_code: 200, body: json_response}) do
    Poison.Parser.parse(json_response)
  end

  use Publicist

  defp convert({:ok, rates}, amount) do
    rate = find_dollar([rates])
    amount / rate
  end

  defp find_dollar([%{"rates" => %{"USD" => rate}} | _]) do
    rate
  end

  defp find_dollar([_ | tail]) do
    find_dollar(tail)
  end

  defp find_dollar([]) do
    raise "No rate found for Dollar"
  end
end

# Budget.Conversion.from_dollar_to_euro(12)
