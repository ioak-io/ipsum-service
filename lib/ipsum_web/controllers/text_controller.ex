defmodule IpsumWeb.TextController do
    use IpsumWeb, :controller
  
    alias Ipsum.RandomText
    alias Ipsum.LoremText
    
    def generate(conn, %{"language" => language, "type" => type}) do
        strategy = if Map.has_key?(conn.query_params, "strategy"), do: conn.query_params["strategy"], else: "lorem"
        count = get_int_from_query(conn.query_params, 5)
        case strategy do
            "random" -> render(conn, "index.json", texts: RandomText.generate_sentence(language, type, count))
            _ -> render(conn, "index.json", texts: LoremText.generate_sentence(language, type, count))
        end
        
    end

    def get_int_from_query(query_params, default_value) do
        if Map.has_key?(query_params, "count") do
            case Integer.parse(query_params["count"]) do
                {count, _} -> count
                {_, _} -> default_value
                _ -> default_value
            end
        else
            default_value
        end
    end

    def get_corpus(conn, payload) do
        # [%{"text" => "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."
        # result = "Es liberal en estremo -dijo don Quijote-, y si no te dio joya de oro, sin duda debió de ser porque no la tendría allí a la mano para dártela; pero buenas son mangas después de Pascua: yo la veré, y se satisfará todo Sabes de qué estoy maravillado, Sancho? De que me parece que fuiste y veniste por los aires, pues poco más de tres días has tardado en ir y venir desde aquí al Toboso, habiendo de aquí allá más de treinta leguas; por lo cual me doy a entender que aquel sabio nigromante que tiene cuenta con mis cosas y es mi amigo (porque por fuerza le hay, y le ha de haber, so pena que yo no sería buen caballero andante); digo que este tal te debió de ayudar a caminar, sin que tú lo sintieses; que hay sabio déstos que coge a un caballero andante durmiendo en su cama, y, sin saber cómo o en qué manera, amanece otro día más de mil leguas de donde anocheció. Y si no fuese por esto, no se podrían socorrer en sus peligros los caballeros andantes unos a otros, como se socorren a cada paso. Que acaece estar uno peleando en las sierras de Armenia con algún endriago, o con algún fiero vestiglo, o con otro caballero, donde lleva lo peor de la batalla y está ya a punto de muerte, y cuando no os me cato, asoma por acullá, encima de una nube, o sobre un carro de fuego, otro caballero amigo suyo, que poco antes se hallaba en Ingalaterra, que le favorece y libra de la muerte, y a la noche se halla en su posada, cenando muy a su sabor; y suele haber de la una a la otra parte dos o tres mil leguas. Y todo esto se hace por industria y sabiduría destos sabios encantadores que tienen cuidado destos valerosos caballeros. Así que, amigo Sancho, no se me hace dificultoso creer que en tan breve tiempo hayas ido y venido desde este lugar al del Toboso, pues, como tengo dicho, algún sabio amigo te debió de llevar en volandillas, sin que tú lo sintieses"
        result = 
        payload["data"]
        |> String.downcase
        |> String.replace(".", "")
        |> String.replace(",", "")
        |> String.replace("-", "")
        |> String.replace("(", "")
        |> String.replace(")", "")
        |> String.replace(";", "")
        |> String.replace(":", "")
        |> String.replace("?", "")
        |> String.replace("!", "")
        |> String.split(" ")
        |> Enum.uniq
        render(conn, "corpus.json", texts: result)
    end
end