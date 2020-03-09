defmodule B2mlWeb.PageControllerTest do
  use B2mlWeb.ConnCase
  import B2mlWeb.Gettext

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ gettext("Welcome to %{name}!", %{name: "B2ml School"})
  end
end
