defmodule Fpbackend.UserView do
  use Fpbackend.Web, :view

  def render("index.json", %{users: users}) do
    render_many(users, Fpbackend.UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, Fpbackend.UserView, "user.json")
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
end
