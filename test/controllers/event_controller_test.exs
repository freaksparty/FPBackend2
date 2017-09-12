defmodule Fpbackend.EventControllerTest do
  use FpbackendWeb.ConnCase

  alias Fpbackend.Event
  @valid_attrs %{date_end: %{day: 17, month: 4, year: 2010}, date_start: %{day: 17, month: 4, year: 2010}, description: "some content", minimum_age: 42, name: "some content", num_participants: 42, price: 42, reg_date_close: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, reg_date_open: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, rules: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, event_path(conn, :index)
    assert json_response(conn, 200) == []
  end

  test "shows chosen resource", %{conn: conn} do
    event = Repo.insert! %Event{}
    conn = get conn, event_path(conn, :show, event)
    assert json_response(conn, 200) == %{"id" => event.id,
      "name" => "",
      "description" => event.description,
      "num_participants" => 1,
      "minimum_age" => 0,
      "price" => 0,
      "date_start" => "0000-00-00",
      "date_end" => "0000-00-00",
      "reg_date_open" => "0000-00-00T00:00:00",
      "reg_date_close" => "0000-00-00T00:00:00",
      "rules" => event.rules}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, event_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @valid_attrs
    assert json_response(conn, 201)["id"]
    assert Repo.get_by(Event, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    event = Repo.insert! %Event{}
    conn = put conn, event_path(conn, :update, event), event: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Event, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    event = Repo.insert! %Event{}
    conn = put conn, event_path(conn, :update, event), event: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    event = Repo.insert! %Event{}
    conn = delete conn, event_path(conn, :delete, event)
    assert response(conn, 204)
    refute Repo.get(Event, event.id)
  end
end
