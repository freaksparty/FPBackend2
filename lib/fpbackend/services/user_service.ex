defmodule Fpbackend.Services.UserService do
  use Fpbackend.Web, :fpbackend_service

  alias FpbackendWeb.User

  def repo(), do: User
  def model_struct(), do: %User{}
  def create_changeset(struct, params), do: User.registration_changeset(struct, params)
  def update_changeset(struct, params), do: User.changeset(struct, params)

  def find_by_email_and_password(email, password) do    
    with %User{}=user <- Repo.get_by(User, email: email),
         true <- User.check_password(password, user.password_hash) do     
      {:ok, user}
    else
      _ -> {:error, :incorrect_user_or_password}
    end
  end

end
