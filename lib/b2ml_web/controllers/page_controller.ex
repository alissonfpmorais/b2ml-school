defmodule B2mlWeb.PageController do
  use B2mlWeb, :controller

  def index(%Plug.Conn{params: %{"current_path" => current_path}} = conn, _params) do
    redirect_to =
      case current_path do
        path = "/" <> _ ->
          path

        _ ->
          "/"
      end

    conn
    |> redirect(to: redirect_to)
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
