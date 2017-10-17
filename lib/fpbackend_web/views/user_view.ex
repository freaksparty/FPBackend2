defmodule FpbackendWeb.UserView do
  use Fpbackend.Web, :view

  def render("many.json", %{users: users}) do
    render_many(users, FpbackendWeb.UserView, "user.json")
  end

  def render("one.json", %{user: user}) do
    render_one(user, FpbackendWeb.UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      login: user.login,
      checked: user.checked,
      name: user.name,
      dni: user.dni,
      email: user.email,
      phone: user.phone,
      shirt_size: user.shirt_size,
      borndate: user.borndate}
  end

  def render("name.json", %{user: user}) do
    %{id: user.id,
      name: user.name}
  end
end
