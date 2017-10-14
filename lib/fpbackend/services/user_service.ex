defmodule Fpbackend.Services.UserService do
  use Fpbackend.Web, :fpbackend_service

  alias FpbackendWeb.User

  def repo(), do: User
  def model_struct(), do: %User{}
  def create_changeset(struct, params), do: User.registration_changeset(struct, params)
  def update_changeset(struct, params), do: User.changeset(struct, params)

end
