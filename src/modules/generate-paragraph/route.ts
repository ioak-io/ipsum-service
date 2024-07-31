import express, { Request, Response } from 'express';
import { getGeneratedParagraph } from './service';

// Define the interface for the request body to ensure type safety
interface GenerateParagraphRequest extends Request {
  body: {
    topic: string;
  };
}

// Use module.exports to export the router setup function
module.exports = function (router: express.Router) {
  router.post('/generate-paragraph', async (req: GenerateParagraphRequest, res: Response) => {
    const { topic } = req.body;

    const model_name = 'gpt-3.5-turbo';
    const number_of_sentences = 20;
    const authorization_key = 'a53dc337-a203-4980-bfc8-12f19acddd26';

    const result = await getGeneratedParagraph({
      model_name,
      number_of_sentences,
      topic,
      authorization_key
    });

    res.status(result.code).json(result);
  });
};
;
