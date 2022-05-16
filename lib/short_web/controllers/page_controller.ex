defmodule ShortWeb.PageController do
  use ShortWeb, :controller
  require Logger

  def index(conn, _params) do
    render(conn, "index.html", homeurl: ShortWeb.Router.Helpers.url(conn), csrf: Phoenix.Controller.get_csrf_token())
  end

  def unveil(conn, %{"customurl" => customurl}) do
    case Short.Queries.fetch_url(customurl) do
      {:ok, url} -> redirect(conn, external: url)
      {:error, :notfound} -> conn|>put_flash(:error, "url not found")|>redirect(to: Routes.page_path(conn, :index))
      {:error, err} -> conn|>put_flash(:error, err)|>redirect(to: Routes.page_path(conn, :index))
    end
  end

  def add(conn, request_body) do
    Logger.debug ShortWeb.Router.Helpers.url(conn)
    Logger.debug request_body["customurl"]
    case Short.Queries.add_url(request_body["customurl"], request_body["url"]) do
      {:ok, _} -> conn|>put_flash(:info, "success: " <> ShortWeb.Router.Helpers.url(conn) <> request_body["customurl"])|>redirect(to: Routes.page_path(conn, :index))
      {:error, err} -> conn|>put_flash(:error, ShortWeb.HumanizeError.add_err(err))|>redirect(to: Routes.page_path(conn, :index))
    end
  end
end
