import axios from "axios";

const model_name = "gpt-3.5-turbo";
const number_of_sentences = 20;
const authorization_key = "a53dc337-a203-4980-bfc8-12f19acddd26";

export const generate = async (text: string) => {
  const endpoint = "https://api.ioak.io:8120/api/v1/chat/completions";

  const headers = {
    Authorization: authorization_key,
    "Content-Type": "application/json",
  };

  const payload = {
    model: model_name,
    messages: [
      {
        role: "system",
        content:
          "Overall Objective: Assist user in generating a paragraph of given number of sentences related to the below topic given. Number of words in any sentence should be less than 15 words and at least 7 words",
      },
      {
        role: "user",
        content: `Number of sentences to be generated: ${number_of_sentences}\nTopic: ${text}`,
      },
    ],
    temperature: 1,
    max_tokens: 4096,
    top_p: 1,
    frequency_penalty: 0,
    presence_penalty: 0,
  };

  try {
    const response = await axios.post(endpoint, payload, { headers });

    // console.log('Response status:', response.status);
    // console.log('Response:', JSON.stringify(response.data.data, null, 2)); // Log the entire response data with proper formatting

    if (response.status === 200) {
      const responseData = response.data.data;

      // Log the choices to see the actual objects
      // console.log('Response choices:', JSON.stringify(responseData.choices, null, 2));

      if (responseData.choices && responseData.choices.length > 0) {
        const content = responseData.choices[0].message.content;
        const sentencesArray = content.split('.').map((sentence: string) => sentence.trim()).filter((sentence: string) => sentence.length > 0);
        return sentencesArray;
      }
    }
  } catch (error) {
    if (error instanceof Error) {
      console.error("Request failed:", error.message);
    } else {
      console.error("Request failed:", error);
    }
  }
  return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
};
