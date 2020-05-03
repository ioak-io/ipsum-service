defmodule Ipsum.VerbGet do
    alias Ipsum.Mock
    alias Ipsum.Text

    def run(id) do
        domain = Mock.get_domain!(id)
        generate(domain.stub, 5)
    end

    defp generate(node, count) when count > 1 do
        [handle(node) | generate(node, count - 1)]
    end
    
    defp generate(node, count) when count == 1 do
        [handle(node)]
    end

    defp handle(node) when is_map(node) do
        first_key = 
            node
            |> Map.keys
            |> List.first

        tail_node = 
            Map.delete(node, first_key)

        datagen = %{ first_key => handle(node[first_key]) }
        if map_size(tail_node) > 0 do 
            tail_node
            |> handle
            |> Map.merge(datagen)
        else
            datagen
        end
    end

    defp handle(node) when is_binary(node) do
        get_data_for_datatype(node)
    end

    defp handle([head | _]) do
        if is_map(head) do
            count = if Map.has_key?(head, "__number_of_times"), do:
                head["__number_of_times"]
                |> get_precision
                |> Text.random_number,
            else:
                Text.random_number({5, 10})
            
            head
            |> Map.delete("__number_of_times")
            |> generate(count)
        else
            "ERROR_array_structure_datatype_can_contain_only_an_object"
        end
    end

    defp get_precision([head | tail]) do
        {head, (if length(tail) == 1, do: List.first(tail), else: head)}
    end

    defp get_data_for_datatype(datatype) do
    # when String.starts_with?(datatype, "sentence") do
        "lorem ipsum"
    end
end