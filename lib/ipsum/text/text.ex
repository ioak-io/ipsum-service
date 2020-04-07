defmodule Ipsum.Text do

    def generate_sentence(language, type, count) do
        get_text(language, type, count)
        |> compose_as_object
    end
    defp compose_as_object([head | tail]) do
        if Enum.count(tail) !== 0 do
            [%{"id" => Enum.count(tail) + 1, "text" => head} | compose_as_object(tail)]
        else
            [%{"id" => Enum.count(tail) + 1, "text" => head}]
        end
    end
    defp get_text(language, type, count) do
        case type do
            "sentence" -> random_sentences(language, count)
            "paragraph" -> random_paragraphs(language, count)
            _ -> random_sentences(language, count)
        end
    end
    defp random_paragraphs(language, count) do
        if count > 1 do
            [random_paragraph(language) | random_paragraphs(language, count-1)]
        else
            [random_paragraph(language)]
        end
    end
    defp random_paragraph(language) do
        random_sentences(language, random_number(4, 7))
        |> Enum.join(". ")
    end
    defp random_sentences(language, count) do
        if count > 1 do
            [random_sentence(language) | random_sentences(language, count-1)]
        else
            [random_sentence(language)]
        end
    end
    defp random_sentence(language) do
        random_words(language, random_number(15, 24))
        |> Enum.join(" ")
        |> String.capitalize
    end
    defp random_words(language, word_count) do
        if word_count > 1 do
            [random_word(language) | random_words(language, word_count-1)]
        else
            [random_word(language)]
        end
    end
    defp random_word(language) do
        language
        |> charset
        |> String.graphemes
        |> Enum.take_random(random_number(2, 10))
        |> Enum.join("")
    end
    defp charset(language) do
        if language === "en" do
            "abcdefghijklmnopqrstuvwxyz"
        end
    end
    defp random_number(a,b) do
        a - 1 + :rand.uniform(b-a+1)
    end
end
