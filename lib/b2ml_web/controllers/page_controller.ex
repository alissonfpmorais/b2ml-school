defmodule B2mlWeb.PageController do
  use B2mlWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
