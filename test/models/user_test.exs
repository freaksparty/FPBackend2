defmodule Fpbackend.UserTest do
  use Fpbackend.ModelCase

  alias Fpbackend.User

  @valid_attrs %{blacklist: true, borndate: %{day: 17, month: 4, year: 2010}, checked: true, dni: "some content", email: "some@some.com", login: "some content", name: "some content", password: "some content", phone: "some content", shirt_size: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
