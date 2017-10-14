defmodule FpbackendWeb.UserController do
  use Fpbackend.Web, :fpbackend_controller

  def service(), do: Fpbackend.Services.UserService
  def many_key(), do: :users
  def one_key(), do: :user

  def index(conn, _params), do: conn |> base_index()
  def show(conn, %{"id" => id}), do: conn |> base_show(id)
  def create(conn, %{"user" => user_params}), do: conn |> base_create(user_params)
  def update(conn, %{"id" => id, "user" => user_params}), do: conn |> base_update(id, user_params)
  def delete(conn, %{"id" => id}), do: conn |> base_delete(id)
end
