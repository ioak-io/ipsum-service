defmodule Ipsum.Flatten do
    alias Ipsum.Mock
    alias Ipsum.Text

    import Ecto

    def run(data, meta) do
        meta |> IO.inspect
        hierarchy = 
            decompose(Ecto.UUID.generate, nil, meta["root_node"], data, 0, meta)
        
        hierarchy_lookup = mapize(hierarchy, %{})
        hierarchy
        |> List.keysort(4)
        |> Enum.reverse
        |> extract_keys_from_tuple
        |> Enum.uniq
        |> flatten(hierarchy_lookup, [])
    end

    defp decompose(id, parent_id, current_key, node, level, meta) when is_binary(node) do
        [{id, parent_id, current_key, node, level}]
    end

    defp decompose(id, parent_id, current_key, node, level, meta) when is_map(node) do
        first_key = 
            node
            |> Map.keys
            |> List.first

        tail_node = 
            Map.delete(node, first_key)

        if first_key == nil do
           [{id, parent_id, current_key, replace_node_value(node, meta), level}]
        else
            key = if first_key == nil, do: "#{current_key}", else: "#{current_key}.#{first_key}"
            head_data = decompose(id, parent_id, key, node[first_key], level, meta)
            if map_size(tail_node) > 0 do
                tail_data = decompose(id, parent_id, current_key, tail_node, level, meta)
                head_data ++ tail_data
            else
                head_data
            end 
        end
    end

    defp decompose(id, parent_id, current_key, [head | tail], level, meta) do
        if Enum.count(tail) != 0 do
            [{id, parent_id, "__placeholder", "", level}] ++ decompose(Ecto.UUID.generate, id, current_key, head, level + 1, meta) ++ decompose(id, parent_id, current_key, tail, level, meta)
        else
            [{id, parent_id, "__placeholder", "", level}] ++ decompose(Ecto.UUID.generate, id, current_key, head, level + 1, meta)
        end
    end

    defp decompose(id, parent_id, current_key, node, level, meta) when true do
        [{id, parent_id, current_key, replace_node_value(node, meta), level}]
    end

    defp replace_node_value(node, meta) do
        cond do
            is_list(node) && Enum.count(node) == 0 ->
                meta["empty_array"]
            is_map(node) && Enum.count(node) == 0 ->
                meta["empty_object"]
            true -> node
        end
    end

    defp mapize([head | tail], stage) do
        if Map.has_key?(stage, elem(head, 0)) do
            new_stage_element = %{elem(head, 0) => 
                %{
                    elem(head, 2) => elem(head, 3)}
                    |> Map.merge(stage[elem(head, 0)])
                    |> Map.delete("__placeholder")
                }
            new_stage = Map.delete(stage, elem(head, 0)) |> Map.merge(new_stage_element)
            
            if Enum.count(tail) > 0 do
                mapize(tail, new_stage)
            else
                new_stage
            end
        else
            new_stage = %{elem(head, 0) => 
                %{
                    elem(head, 2) => elem(head, 3), "__parent" => elem(head,1)}
                    |> Map.delete("__placeholder")
                } |> Map.merge(stage)
            if Enum.count(tail) > 0 do
                mapize(tail, new_stage)
            else
                new_stage
            end
        end
    end

    defp flatten([head | tail], hierarchy_map, processed_keys) do
        if head in processed_keys do
            if Enum.count(tail) > 0 do
                flatten(tail, hierarchy_map, processed_keys)
            else
                []
            end
        else
            entry = 
            head
            |> trace_hierarchy(hierarchy_map, %{}, processed_keys)
            if Enum.count(tail) > 0 do
                [elem(entry,0)] ++ flatten(tail, hierarchy_map, elem(entry,1))
            else
                [elem(entry,0)]
            end
        end
    end

    defp trace_hierarchy(element_key, hierarchy_map, record, processed_keys) do
        new_processed_keys = [element_key | processed_keys]
        if element_key == nil do
            {record, new_processed_keys}
        else
            {parent_key, new_record} = 
            hierarchy_map
            |> Map.get(element_key)
            |> merge_map(record)
            |> Map.pop("__parent")
            trace_hierarchy(parent_key, hierarchy_map, new_record, new_processed_keys)
        end
    end

    defp extract_keys_from_tuple([head | tail]) do
        if Enum.count(tail) !== 0 do
            [elem(head,0) | extract_keys_from_tuple(tail)]
        else
            [elem(head,0)]
        end
    end

    defp merge_map(a, b) do
        cond do
            a != nil && b != nil ->
                Map.merge(a, b)
            a != nil ->
                a
            b != nil ->
                b
            true ->
                %{}
        end
    end
end