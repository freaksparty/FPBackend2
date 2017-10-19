defmodule Fpbackend.Services.AuthService do
  alias Fpbackend.Guardian
  alias FpbackendWeb.User

  @refresh "refresh"
  @access "access"

  def sign_in(%User{} = user) do
    with {:ok, refresh, _claims} <- generate_refresh_token(user),
         {:ok, access, _claims} <- generate_access_token(user) do
      {:ok, refresh, access}
    end
  end

  def sign_out(refresh_token), do: Guardian.revoke(refresh_token)

  def exchange_token(refresh_token), do: with {:ok, _old, {access_token, _claims}} <- Guardian.exchange(refresh_token, @refresh, @access), do: {:ok, access_token}

  defp generate_access_token(resource), do: generate_token(resource, @access)
  defp generate_refresh_token(resource), do: generate_token(resource, @refresh)

  defp generate_token(resource, type), do: Guardian.encode_and_sign(resource, %{}, token_type: type)
end
  