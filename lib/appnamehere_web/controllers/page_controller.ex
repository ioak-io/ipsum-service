defmodule AppnamehereWeb.PageController do
  use AppnamehereWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
