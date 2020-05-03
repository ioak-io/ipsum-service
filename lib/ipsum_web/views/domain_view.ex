defmodule IpsumWeb.DomainView do
  use IpsumWeb, :view
  alias IpsumWeb.DomainView

  def render("index.json", %{domains: domains}) do
    %{data: render_many(domains, DomainView, "domain.json")}
  end

  def render("show.json", %{domain: domain}) do
    %{data: render_one(domain, DomainView, "domain.json")}
  end

  def render("domain.json", %{domain: domain}) do
    %{id: domain.id,
      name: domain.name,
      description: domain.description,
      stub: domain.stub}
  end
end
