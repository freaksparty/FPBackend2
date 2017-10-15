defmodule Fpbackend.Services.SponsorService do
  use Fpbackend.Web, :fpbackend_service

  alias FpbackendWeb.Sponsor

  def repo(), do: Sponsor
  def model_struct(), do: %Sponsor{}
  def create_changeset(struct, params), do: Sponsor.changeset(struct, params)
  def update_changeset(struct, params), do: Sponsor.changeset(struct, params)

  def from_event_query(event_id), do: from sponsor in Sponsor, where: sponsor.event_id == ^event_id

end
