defmodule IpsumWeb.DomainController do
  use IpsumWeb, :controller

  alias Ipsum.Mock
  alias Ipsum.Mock.Domain

  action_fallback IpsumWeb.FallbackController

  def index(conn, _params) do
    domains = Mock.list_domains()
    render(conn, "index.json", domains: domains)
  end

  def create(conn, %{"domain" => domain_params}) do
    IO.inspect(domain_params)
    with {:ok, %Domain{} = domain} <- Mock.create_domain(domain_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.domain_path(conn, :show, domain))
      |> render("show.json", domain: domain)
    end
  end

  def show(conn, %{"id" => id}) do
    domain = Mock.get_domain!(id)
    render(conn, "show.json", domain: domain)
  end

  def update(conn, %{"id" => id, "domain" => domain_params}) do
    domain = Mock.get_domain!(id)

    with {:ok, %Domain{} = domain} <- Mock.update_domain(domain, domain_params) do
      render(conn, "show.json", domain: domain)
    end
  end

  def delete(conn, %{"id" => id}) do
    domain = Mock.get_domain!(id)

    with {:ok, %Domain{}} <- Mock.delete_domain(domain) do
      send_resp(conn, :no_content, "")
    end
  end
end
