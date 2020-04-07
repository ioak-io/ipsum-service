defmodule IpsumWeb.TextController do
    use IpsumWeb, :controller
  
    alias Ipsum.Text
    
    def generate(conn, %{"language" => language, "type" => type}) do
        count = get_int_from_query(conn.query_params, 5)
        texts = Text.generate_sentence(language, type, count)
        render(conn, "index.json", texts: texts)
    end

    def get_int_from_query(query_params, default_value) do
        if Map.has_key?(query_params, "count") do
            {count, _} = Integer.parse(query_params["count"])
            count
        else
            default_value
        end
    end
end