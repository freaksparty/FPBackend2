defmodule FpbackendWeb.AuthController do
  use Fpbackend.Web, :controller

  alias Fpbackend.Services.AuthService
  alias Fpbackend.Services.UserService

  def sign_in(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- UserService.find_by_email_and_password(email, password),
         {:ok, refresh_token, access_token} <- AuthService.sign_in(user) do
      conn 
      |> assign(:refresh, refresh_token) 
      |> assign(:access, access_token)
      |> ok(:ok, "sign_in.json")
    else
      _ -> conn |> error(:unprocessable_entity)
    end
  end

  def sign_out(conn, %{"refresh_token" => refresh_token}) do
    case AuthService.sign_out(refresh_token) do
      {:ok, _} -> ok(conn, :no_content)
      _ -> error(conn, :unprocessable_entity)
    end
  end

  def exchange(conn, %{"refresh_token" => refresh_token}) do
    case AuthService.exchange_token(refresh_token) do
      {:ok, access_token} -> conn |> assign(:access, access_token) |> ok(:ok, "exchange.json")
      _ -> conn |> error(:unprocessable_entity)
    end
  end
end
