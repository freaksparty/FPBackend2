defmodule FpbackendWeb.ChangesetView do
  use Fpbackend.Web, :view

  def render("error.json", %{changeset: changeset}) do
    %{errors: parse_errors(changeset.errors)}
  end

  defp parse_errors(errors), do: parse_errors(%{}, errors)

  defp parse_errors(map, []), do: map
  defp parse_errors(map, [{field, {message, _}} | errors]) do
    case Map.get(map, field) do
      nil -> Map.put(map, field, [message]) |> parse_errors(errors)
      list -> Map.put(map, field, [message | list]) |> parse_errors(errors)
    end
  end
end
