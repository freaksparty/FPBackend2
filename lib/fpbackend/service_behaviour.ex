defmodule FpbackendWeb.Service do
  @callback repo() :: atom
  @callback model_struct() :: %{}
  @callback create_changeset(%{}, %{}) :: {%Ecto.Changeset{}} | {:error, %Ecto.Changeset{}}
  @callback update_changeset(%{}, %{}) :: {%Ecto.Changeset{}} | {:error, %Ecto.Changeset{}}
end
