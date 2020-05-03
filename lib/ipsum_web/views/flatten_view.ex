defmodule IpsumWeb.FlattenView do
  use IpsumWeb, :view
  alias IpsumWeb.FlattenView

  def render("index.json", %{dataset: dataset}) do
    dataset
  end
end
