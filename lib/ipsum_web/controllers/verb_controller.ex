defmodule IpsumWeb.VerbController do
    use IpsumWeb, :controller

    alias Ipsum.VerbGet
  
    action_fallback IpsumWeb.FallbackController
  
    def get(conn, %{"id" => id}) do
      dataset = VerbGet.run(id)
      render(conn, "index.json", dataset: dataset)
    end
end
  