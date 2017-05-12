defmodule Rentapay.Transform do
  def camelize_keys(list) when is_list(list), do: Enum.map(list, fn(map) -> camelize_keys(map) end)
  def camelize_keys(map) do
    Map.keys(map) 
    |> List.foldl(%{}, fn(x, acc) -> Map.put(acc, Inflex.camelize(x, :lower), process_value(map[x])) end) 
  end

  defp process_value(value) when is_map(value) do
    camelize_keys(value)
  end
  defp process_value(value), do: value
end
