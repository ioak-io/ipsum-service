defmodule Ipsum.LoremText do

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
        |> wordset
        |> Enum.take_random(1)
    end
    defp wordset(language) do
        case language do
            "de" -> ["wer","in","ein","fremdes","land","kommt","wird","manchmal","die","sprache","der","einheimischen","durch","hinweisende","erklärungen","lernen","sie","ihm","geben","und","er","deutung","dieser","oft","raten","müssen","richtig","falsch","nun","können","wir","glaube","ich","sagen","augustinus","beschreibe","das","menschlichen","so","als","käme","kind","verstehe","des","landes","nicht","heißt","habe","es","bereits","eine","nur","diese","oder","auch","könne","schon","denken","noch","sprechen","hieße","hier","etwas","wie","zu","sich","selber","reden","man","kann","für","große","klasse","von","fällen","benützung","wortes","bedeutung","a","wenn","alle","fälle","seiner","dieses","wort","erklären","eines","ist","sein","gebrauch","namens","erklärt","dadurch","daß","auf","seinen","träger","zeigt","sagten","satz","nothung","hat","scharfe","schneide”","sinn","zerschlagen","weil","diesem","sprachspiel","name","abwesenheit","seines","trägers","gebraucht","aber","uns","mit","namen","zeichen","gewiß","nennen","werden","welchem","anwesenheit","also","immer","ersetzt","fürwort","hinweisenden","gebärde","nie","trägerlos","könnte","solange","gibt","ob","einfach","zusammengesetzt","istaber","macht","eben","einem","im","gegenteil","denn","geste","verwendet","sondern","zwei","bilder","rose","finstern","ganz","schwarz","unsichtbar","andern","allen","einzelheiten","gemalt","schwärze","umgeben","ihnen","andere","einer","weißen","roten","doch","ließen","unterscheiden"]
            "fr" -> ["cet","issachar","était","le","plus","colérique","hébreu","qu'on","eût","vu","dans","israël","depuis","la","captivité","en","babylone","","quoi","ditil","chienne","de","galiléenne","ce","n'est","pas","assez","monsieur","l'inquisiteur","il","faut","que","coquin","partage","aussi","avec","moi","disant","cela","tire","un","long","poignard","dont","toujours","pourvu","et","ne","croyant","son","adverse","partie","des","armes","se","jette","sur","candide","mais","notre","bon","vestphalien","avait","reçu","une","belle","épée","vieille","l'habit","complet","quoiqu'il","les","moeurs","fort","douces","vous","étend","l'israélite","roide","mort","carreau","aux","pieds","cunégonde","sainte","vierge","s'écriatelle","qu'allonsnous","devenir","homme","tué","chez","si","justice","vient","nous","sommes","perdus","pangloss","n'avait","été","pendu","dit","donnerait","conseil","cette","extrémité","car","c'était","grand","philosophe","a","défaut","consultons","elle","prudente","commençait","à","dire","avis","quand","autre","petite","porte","s'ouvrit","heure","après","minuit","commencement","du","dimanche","jour","appartenait","monseigneur","entre","voit","fessé","l'épée","main","étendu","par","terre","effarée","donnant","conseils","voici","moment","qui","passa","l'âme","comment","raisonna","saint","appelle","secours","me","fera","infailliblement","brûler","pourra","faire","autant","m'a","fait","fouetter","impitoyablement","est","mon","rival","je","suis","train","tuer","n'y","balancer","raisonnement","fut","net","rapide","sans","donner","temps","revenir","sa","surprise","perce","d'outre","outre","côté","juif","bien","d'une","rémission","excommuniés","dernière","venue","avezvous","êtes","né","doux","pour","deux","minutes","prélat","ma","demoiselle","répondit","on","amoureux","jaloux","fouetté","l'inquisition","connaît","prit","alors","parole","y","trois","chevaux","andalous","l'écurie","leurs","selles","brides","brave","prépare","madame","moyadors","diamants","montons","vite","cheval","quoique","puisse","tenir","fesse","allons","cadix","beau","monde","c'est","plaisir","voyager","pendant","fraîcheur","nuit","aussitôt","selle","lui","font","trente","milles","traite","qu'ils","s'éloignaient","hermandad","arrive","maison","enterre","église","voirie","étaient","déjà","ville","d'avacéna","au","milieu","montagnes","sierramorena","ils","parlaient","ainsi","cabaret"]
            "ta" -> ["பொன்னியின்","செல்வரைக்","கொடுத்து","விடுங்கள்","இல்லாவிடில்","விஹாரத்தை","இடித்துத்","தரை","மட்டமாக்கி","விடுவோம்”","என்பவை","போன்ற","மொழிகள்","ஏக","காலத்தில்","ஆயிரக்கணக்கான","குரோதம்","நிறைந்த","குரல்களிலிருந்து","வெளியாகிச்","சமுத்திர","கோஷத்தைப்","போல்","கேட்டது","அதே","சமயத்தில்","கடலின்","பேரோசையும்","அதிகமாகிக்","கொண்டிருப்பதை","ஆச்சாரிய","பிக்ஷு","கவனித்துக்","கொண்டார்","இளம்","கூறியது","உண்மைதான்","அளவிலாத","வேகம்","பொருந்திய","கொடும்புயல்","கடற்கரையை","நோக்கி","வந்து","கொண்டிருக்கிறது","அதி","சீக்கிரத்தில்","புயல்","கரையைத்","தாக்கப்போகிறது","இந்த","மக்களால்","ஏற்படும்","அபாயத்துக்குப்","பிழைத்தாலும்","புயலின்","கொடுமையிலிருந்து","விஹாரம்","தப்பிப்","பிழைக்க","வேண்டும்","என்ற","கவலை","பிக்ஷுவுக்கு","ஏற்பட்டது","நீங்கள்","எல்லோரும்","இங்கே","கூடியிருப்பதின்","நோக்கத்தை","அறிந்து","கொண்டேன்","சக்கரவர்த்தியின்","திருக்குமாரரும்","செல்வருமான","இளவரசர்","அருள்மொழிவர்மரிடம்","உங்களுக்கெல்லாம்","எவ்வளவு","அன்பு","உண்டு","என்பது","இன்றைக்கு","எனக்கு","நன்றாய்த்","தெரிந்தது","உங்களைப்","போலவே","அடியேனும்","செல்வரிடம்","அன்புடையவன்","தான்","அருள்மொழிவர்மர்","கடலில்","மூழ்கி","விட்டார்","செய்தி","அன்று","காலையில்","நான்","இதே","இடத்தில்","நின்று","கண்ணீர்","அருவி","பெருக்கினேன்","புத்த","தர்மத்தில்","பற்றுக்","கொண்டவர்","எவரும்","கொள்ளாமல்","இருக்கமுடியாது","தர்மத்துக்கும்","பிக்ஷுக்களுக்கும்","அவர்","அத்தகைய","மகத்தான","உபகாரங்களைச்","செய்திருக்கிறார்","புத்தர்களின்","புண்ணிய","க்ஷேத்திரமாகிய","அனுராதபுரத்தில்","மன்னர்களின்","இடிந்து","தகர்ந்து","பாழான","விஹாரங்களையும்","ஸ்தூபங்களையும்","திருப்பணி","செய்து","செப்பனிடுவதற்கு","ஏற்பாடு","செய்தவர்","அப்படிப்பட்ட","உத்தமரான","இளவரசருக்கு","எந்த","வகையிலும்","தீங்கு","நேர","நாங்கள்","உடந்தையாக","இருக்க","முடியுமா","ஒன்றும்","நேராமல்","அவரைக்","கடல்","கொண்ட","பொய்யாயிருக்க","என்று","பிரார்த்தனை","செய்த","வண்ணம்","இருந்தோம்","உங்களையெல்லாம்","விடப்","அன்புடையவர்களாயிருப்பதற்குக்","காரணங்கள்"]
            "es" -> ["notó","anselmo","la","remisión","de","lotario","y","formó","dél","quejas","grandes","diciéndole","que","si","él","supiera","el","casarse","había","ser","parte","para","no","comunicalle","como","solía","jamás","lo","hubiera","hecho","por","buena","correspondencia","los","dos","tenían","mientras","fue","soltero","habían","alcanzado","tan","dulce","nombre","llamados","amigos","permitiese","querer","hacer","del","circunspecto","sin","otra","ocasión","alguna","famoso","agradable","se","perdiese","así","le","suplicaba","era","lícito","tal","término","hablar","usase","entre","ellos","volviese","a","señor","su","casa","entrar","salir","en","ella","antes","asegurándole","esposa","camila","tenía","otro","gusto","ni","voluntad","quería","tuviese","haber","sabido","con","cuántas","veras","amaban","estaba","confusa","ver","tanta","esquiveza","todas","estas","otras","muchas","razones","dijo","persuadille","respondió","prudencia","discreción","aviso","quedó","satisfecho","intención","amigo","quedaron","concierto","días","semana","las","fiestas","fuese","comer","aunque","esto","concertado","propuso","más","aquello","viese","convenía","honra","cuyo","crédito","estimaba","suyo","proprio","decía","bien","casado","quien","cielo","concedido","mujer","hermosa","tanto","cuidado","tener","qué","llevaba","mirar","amigas","conversaba","porque","hace","concierta","plazas","templos","públicas","estaciones","cosas","veces","han","negar","maridos","sus","mujeres","facilita","amiga","o","parienta","satisfación","tiene"]
            "ru" -> ["понятно","что","таким","представлялось","дело","современникам","наполеону","казалось","причиной","войны","были","интриги","англии","как","он","и","говорил","это","на","острове","св","елены","членам","английской","палаты","было","властолюбие","наполеона","принцу","ольденбургскому","совершенное","против","него","насилие","купцам","была","континентальная","система","разорявшая","европу","старым","солдатам","генералам","главной","необходимость","употребить","их","в","легитимистам","того","времени","то","необходимо","восстановить","les","bons","principes","2","а","дипломатам","все","произошло","оттого","союз","россии","с","австрией","1809","году","не","был","достаточно","искусно","скрыт","от","неловко","написан","mémorandum","за","№","178","эти","еще","бесчисленное","бесконечное","количество","причин","которых","зависит","бесчисленного","различия","точек","зрения","но","для","нас","","потомков","созерцающих","во","всем","его","объеме","громадность","совершившегося","события","вникающих","простой","страшный","смысл","причины","представляются","недостаточными","непонятно","чтобы","миллионы","людейхристиан","убивали","мучили","друг","друга","потому","наполеон","властолюбив","александр","тверд","политика","хитра","герцог","ольденбургский","обижен","нельзя","понять","какую","связь","имеют","обстоятельства","самым","фактом","убийства","насилия","почему","вследствие","тысячи","людей","другого","края","европы","разоряли","смоленской","московской","губерний","убиваемы","ими","историков","увлеченных","процессом","изыскания","незатемненным","здравым","смыслом","событие","неисчислимом","количестве","чем","больше","мы","углубляемся","изыскание","тем","нам","открывается","всякая","отдельно","взятая","причина","или","целый","ряд","одинаково","справедливыми","сами","по","себе","ложными","своей","ничтожности","сравнении","громадностью","недействительности","без","участия","всех","других","совпавших","произвести","совершившееся","такой","же","отказ","отвести","свои","войска","вислу","отдать","назад","герцогство","ольденбургское","представляется","желание","нежелание","первого","французского","капрала","поступить","вторичную","службу","ибо","ежели","бы","захотел","идти","другой","третий","тысячный","капрал","солдат","настолько","менее","войске","могло","быть"]
            _ -> ["sed","ut","perspiciatis","unde","omnis","iste","natus","error","sit","voluptatem","accusantium","doloremque","laudantium","totam","rem","aperiam","eaque","ipsa","quae","ab","illo","inventore","veritatis","et","quasi","architecto","beatae","vitae","dicta","sunt","explicabo","nemo","enim","ipsam","quia","voluptas","aspernatur","aut","odit","fugit","consequuntur","magni","dolores","eos","qui","ratione","sequi","nesciunt","neque","porro","quisquam","est","dolorem","ipsum","dolor","amet","consectetur","adipisci","velit","non","numquam","eius","modi","tempora","incidunt","labore","dolore","magnam","aliquam","quaerat","ad","minima","veniam","quis","nostrum","exercitationem","ullam","corporis","suscipit","laboriosam","nisi","aliquid","ex","ea","commodi","consequatur","autem","vel","eum","iure","reprehenderit","in","voluptate","esse","quam","nihil","molestiae","illum","fugiat","quo","nulla","pariatur","at","vero","accusamus","iusto","odio","dignissimos","ducimus","blanditiis","praesentium","voluptatum","deleniti","atque","corrupti","quos","quas","molestias","excepturi","sint","occaecati","cupiditate","provident","similique","culpa","officia","deserunt","mollitia","animi","id","laborum","dolorum","fuga","harum","quidem","rerum","facilis","expedita","distinctio","nam","libero","tempore","cum","soluta","nobis","eligendi","optio","cumque","impedit","minus","quod","maxime","placeat","facere","possimus","assumenda","repellendus","temporibus","quibusdam","officiis","debitis","necessitatibus","saepe","eveniet","voluptates","repudiandae","recusandae","itaque","earum","hic","tenetur","a","sapiente","delectus","reiciendis","voluptatibus","maiores","alias","perferendis","doloribus","asperiores","repellat"]
        end
    end
    def random_number({lower, upper}) do
        lower - 1 + :rand.uniform(upper-lower+1)
    end
end
