defmodule Fpbackend.EventTest do
  use Fpbackend.ModelCase

  alias Fpbackend.Event

  @valid_attrs %{date_end: %{day: 17, month: 4, year: 2010}, date_start: %{day: 17, month: 4, year: 2010}, description: "some content", minimum_age: 42, name: "some content", num_participants: 42, price: 42, reg_date_close: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, reg_date_open: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, rules: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
