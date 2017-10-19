defmodule Fpbackend.Guardian do
  use Guardian, otp_app: :fpbackend

  alias Fpbackend.Repo
  alias FpbackendWeb.User

  def subject_for_token(%User{} = user, _claims) do
    {:ok, to_string(user.id)}
  end

  def subject_for_token(_, _) do
    {:error, :bad_resource}
  end

  def resource_from_claims(%{"sub" => user_id}) do
    case find_user(user_id) do
      nil -> {:error, :user_not_found}
      user -> {:ok, user}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :bad_claims}
  end

  defp find_user(id), do: Repo.get(User, id)

  #Guardian DB

  def after_encode_and_sign(resource, %{"typ"=>"refresh"} = claims, token, _options) do
    with {:ok, _} <- GuardianDb.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def after_encode_and_sign(_, _, token, _), do: {:ok, token}

  def on_verify(%{"typ"=>"refresh"} = claims, token, _options) do
    with {:ok, _} <- GuardianDb.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_verify(claims, _, _), do: {:ok, claims}

  def on_revoke(%{"typ"=>"refresh"} = claims, token, _options) do
    with {:ok, _} <- GuardianDb.on_revoke(claims, token) do
      {:ok, claims}
    end
  end

  def on_revoke(claims, _, _), do: {:ok, claims}
end