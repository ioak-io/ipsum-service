defmodule IpsumWeb.TextView do
    use IpsumWeb, :view
    alias IpsumWeb.TextView
  
    def render("index.json", %{texts: texts}) do
      %{data: render_many(texts, TextView, "text.json")}
    end
    
    def render("text.json", %{text: text}) do
        %{
            id: text["id"],
            text: text["text"]
        }
    end
end