defmodule Fpbackend.ActivityTest do
  use Fpbackend.ModelCase

  alias Fpbackend.Activity

  @valid_attrs %{event_id: 1, date_end: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, date_start: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, description: "some content", image_url: "some content", name: "some content", num_participants: 42, official: true, reg_date_close: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, reg_date_open: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, type: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Activity.changeset(%Activity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Activity.changeset(%Activity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
