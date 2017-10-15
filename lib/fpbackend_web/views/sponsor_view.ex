defmodule FpbackendWeb.SponsorView do
  use Fpbackend.Web, :view

  def render("many.json", %{sponsors: sponsors}) do
    render_many(sponsors, FpbackendWeb.SponsorView, "sponsor.json")
  end

  def render("one.json", %{sponsor: sponsor}) do
    render_one(sponsor, FpbackendWeb.SponsorView, "sponsor.json")
  end

  def render("sponsor.json", %{sponsor: sponsor}) do
    %{id: sponsor.id,
      event_id: sponsor.event_id,
      name: sponsor.name,
      url: sponsor.url,
      image_url: sponsor.image_url }
  end
end
