defmodule FpbackendWeb.AuthView do
  use Fpbackend.Web, :view

  def render("sign_in.json", %{access: access, refresh: refresh}), do: %{access_token: access, refresh_token: refresh}
  def render("exchange.json", %{access: access}), do: %{access_token: access}
end
