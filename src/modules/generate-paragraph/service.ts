import axios from 'axios';

interface GenerateParagraphParams {
  model_name: string;
  number_of_sentences: number;
  topic: string;
  authorization_key: string;
}

export const getGeneratedParagraph = async ({ model_name, number_of_sentences, topic, authorization_key }: GenerateParagraphParams) => {
  const endpoint = "https://api.ioak.io:8120/api/v1/chat/completions";

  const headers = {
    "Authorization": authorization_key,
    "Content-Type": "application/json"
  };

  const payload = {
    model: model_name,
    messages: [
      {
        role: "system",
        content: "Overall Objective: Assist user in generating a paragraph of given number of sentences related to the below topic given"
      },
      {
        role: "user",
        content: `Number of sentences to be generated: ${number_of_sentences}\nTopic: ${topic}`
      }
    ],
    temperature: 1,
    max_tokens: 3071,
    top_p: 1,
    frequency_penalty: 0,
    presence_penalty: 0
  };

  try {
    const response = await axios.post(endpoint, payload, { headers });

    console.log('Response status:', response.status);
    console.log('Response:', JSON.stringify(response.data.data, null, 2)); // Log the entire response data with proper formatting

    if (response.status === 200) {
      const responseData = response.data.data;

      // Log the choices to see the actual objects
      console.log('Response choices:', JSON.stringify(responseData.choices, null, 2));

      if (responseData.choices && responseData.choices.length > 0) {
        const content = responseData.choices[0].message.content;
        return {
          code: 200,
          data: content
        };
      } else {
        return {
          code: 200,
          data: "",
          message: "No content found in choices"
        };
      }
    } else {
      return {
        code: response.status,
        data: null,
        message: response.statusText
      };
    }
  } catch (error) {
    if (error instanceof Error) {
      console.error('Request failed:', error.message);
    } else {
      console.error('Request failed:', error);
    }
    return {
      code: 500,
      data: null,
      message: 'Internal Server Error'
    };
  }
};
