defmodule Ipsum.RandomText do

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
        random_sentences(language, random_number({4, 7}))
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
        random_words(language, random_number({10, 18}))
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
        |> get_readable_word(random_number({2, 10}), (if random_number({0,1}) == 0, do: false, else: true))
    end
    defp get_readable_word({consonants, vowels}, count, is_consonant) when count == 1 do
        get_next_char({consonants, vowels}, is_consonant)
    end
    defp get_readable_word({consonants, vowels}, count, is_consonant) when count > 1 do
        [
            {consonants, vowels} |> get_next_char(is_consonant) | 
            {consonants, vowels} |> get_readable_word(count - 1, !is_consonant)
        ]
    end
    defp get_next_char({consonants, vowels}, is_consonant) when vowels != false do
        (if is_consonant, do: consonants, else: vowels)
        |> String.graphemes
        |> Enum.take_random(1)
    end
    defp get_next_char({consonants, vowels}, is_consonant) when vowels == false do
        consonants
        |> String.graphemes
        |> Enum.take_random(1)
    end
    defp charset(language) do
        case language do
            "de" -> {"ßbcdfghjklmnpqrstvwxyz", "aeiouäeiouaeiöuaeioü"}
            "fr" -> {"bçcdfghjklmnpqrstvwxz", "aeiouyàeiouyaèiouyaeioùyâeiouyaêiouyaeîouyaeiôuyaeioûyaëiouyaeïouyaeioüyaeiouÿ"}
            "ta" -> {"ஃஅகஙசஞடணதநபமயரலவழளறனஜஶஷஸஹக்ஷஆகாஙாசாஞாடாணாதாநாபாமாயாராலாவாழாளாறானாஜாஶாஷாஸாஹாக்ஷாஇகிஙிசிஞிடிணிதிநிபிமியிரிலிவிழிளிறினிஜிஶிஷிஸிஹிக்ஷிஈகீஙீசீஞீடீணீதீநீபீமீயீரீலீவீழீளீறீனீஜீஶீஷீஸீஹீக்ஷீஉகுஙுசுஞுடுணுதுநுபுமுயுருலுவுழுளுறுனுஜுஶுஷுஸுஹுக்ஷுஊகூஙூசூஞூடூணூதூநூபூமூயூரூலூவூழூளூறூனூஜூஶூஷூஸூஹூக்ஷூஎகெஙெசெஞெடெணெதெநெபெமெயெரெலெவெழெளெறெனெஜெஶெஷெஸெஹெக்ஷெஏகேஙேசேஞேடேணேதேநேபேமேயேரேலேவேழேளேறேனேஜேஶேஷேஸேஹேக்ஷேஐகைஙைசைஞைடைணைதைநைபைமையைரைலைவைழைளைறைனைஜைஶைஷைஸைஹைக்ஷைஒகொஙொசொஞொடொணொதொநொபொமொயொரொலொவொழொளொறொனொஜொஶொஷொஸொஹொக்ஷொஓகோஙோசோஞோடோணோதோநோபோமோயோரோலோவோழோளோறோனோஜோஶோஷோஸோஹோக்ஷோஔகௌஙௌசௌஞௌடௌணௌதௌநௌபௌமௌயௌரௌலௌவௌழௌளௌறௌனௌஜௌஶௌஷௌஸௌஹௌக்ஷௌக்ங்ச்ஞ்ட்ண்த்ந்ப்ம்ய்ர்ல்வ்ழ்ள்ற்ன்ஜ்ஶ்ஷ்ஸ்ஹ்க்ஷ்", false}
            "es" -> {"bcdfghjklmnñpqrstvwxyz", "aeiouáeiouaéiouaeíouaeióuaeioúaeioü"}
            "ru" -> {"бвгджзклмнпрстфхцчшщ", "аэыуояеёюи"}
            _ -> {"bcdfghjklmnpqrstvwxyz", "aeiou"}
        end
    end
    def random_number({lower, upper}) do
        lower - 1 + :rand.uniform(upper-lower+1)
    end
end
