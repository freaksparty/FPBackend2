defmodule Fpbackend.ActivityControllerTest do
  use FpbackendWeb.ConnCase

  alias Fpbackend.Activity
  @valid_attrs %{date_end: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, date_start: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, description: "some content", image_url: "some content", name: "some content", num_participants: 42, official: true, reg_date_close: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, reg_date_open: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, type: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  # test "lists all entries on index", %{conn: conn} do
  #   conn = get conn, event_activity_path(conn, :index)
  #   assert json_response(conn, 200) == []
  # end
  #
  # test "shows chosen resource", %{conn: conn} do
  #   activity = Repo.insert! %Activity{}
  #   conn = get conn, event_activity_path(conn, :show, activity)
  #   assert json_response(conn, 200) == %{"id" => activity.id,
  #     "event_id" => activity.event_id,
  #     "name" => "",
  #     "description" => activity.description,
  #     "image_url" => activity.image_url,
  #     "num_participants" => 1,
  #     "type" => 0,
  #     "official" => activity.official,
  #     "date_start" => activity.date_start,
  #     "date_end" => "0000-00-00T00:00:00",
  #     "reg_date_open" => activity.reg_date_open,
  #     "reg_date_close" => "0000-00-00T00:00:00"}
  # end
  #
  # test "renders page not found when id is nonexistent", %{conn: conn} do
  #   assert_error_sent 404, fn ->
  #     get conn, event_activity_path(conn, :show, -1)
  #   end
  # end
  #
  # test "creates and renders resource when data is valid", %{conn: conn} do
  #   conn = post conn, event_activity_path(conn, :create), activity: @valid_attrs
  #   assert json_response(conn, 201)["id"]
  #   assert Repo.get_by(Activity, @valid_attrs)
  # end
  #
  # test "does not create resource and renders errors when data is invalid", %{conn: conn} do
  #   conn = post conn, event_activity_path(conn, :create), activity: @invalid_attrs
  #   assert json_response(conn, 422)["errors"] != %{}
  # end
  #
  # test "updates and renders chosen resource when data is valid", %{conn: conn} do
  #   activity = Repo.insert! %Activity{}
  #   conn = put conn, event_activity_path(conn, :update, activity), activity: @valid_attrs
  #   assert json_response(conn, 200)["id"]
  #   assert Repo.get_by(Activity, @valid_attrs)
  # end
  #
  # test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
  #   activity = Repo.insert! %Activity{}
  #   conn = put conn, event_activity_path(conn, :update, activity), activity: @invalid_attrs
  #   assert json_response(conn, 422)["errors"] != %{}
  # end
  #
  # test "deletes chosen resource", %{conn: conn} do
  #   activity = Repo.insert! %Activity{}
  #   conn = delete conn, event_activity_path(conn, :delete, activity)
  #   assert response(conn, 204)
  #   refute Repo.get(Activity, activity.id)
  # end
end
