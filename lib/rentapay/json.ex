defmodule Rentapay.JSON do
  alias Rentapay.Entity, as: E
  import Rentapay.Transform
  def serialize(data) do
    serializer = lookup_serializer(data) 
    serializer.serialize(data) |> Rentapay.Transform.camelize_keys
  end

  def lookup_serializer(data) do
    Module.concat(Rentapay.Entity, struct_name(data) <> "Serializer")
  end

  def struct_name([struct | _]), do: struct_name(struct)
  def struct_name(struct) do
    Macro.to_string(struct.__struct__) |> String.split(".") |> List.last
  end
end
