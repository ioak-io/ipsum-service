import bcrypt from "bcrypt";
import { validateMandatoryFields } from "../../lib/validation";

import * as Helper from "./helper";
import { getCollection } from "../../lib/dbutils";

const selfRealm = 100;

export const generateText = async (req: any, res: any) => {
  const response: string[][] = await Helper.generateText(req.params.language, req.params.corpus, req.params.type, parseInt(req.params.count), parseInt(req.params.batchSize));
  
  res.status(200);
  res.send(response);
  res.end();
};

export const generateTextForPreset = async (req: any, res: any) => {
  const response: string[][] = await Helper.generateTextForPreset(req.params.presetId, req.params.type, parseInt(req.params.count), parseInt(req.params.batchSize));
  
  res.status(200);
  res.send(response);
  res.end();
};

export const findUniqueWords = async (req: any, res: any) => {
  const response: string[] = await Helper.findUniqueWords(req.body.text);
  
  res.status(200);
  res.send(response);
  res.end();
};
