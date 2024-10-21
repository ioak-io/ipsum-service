import { presetCollection, presetSchema } from "./model";
import * as AiService from "../ai/service";
const { getCollection } = require("../../lib/dbutils");

const AI_GENERATED_SENTENCE_COUNT = 100;

export const findUniqueWords = (payload: string) => {
  const _payload = payload
    .replace(/[0123456789`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, "")
    .replace(/\s\s+/g, " ")
    .toLowerCase()
    .trim();
  const words = _payload.split(" ");
  return removeDuplicates_(words);
};

export const findUniqueSetences = (payload: string) => {
  const _payload = payload
    .replace("\n", " ")
    .replace(/[0123456789`~!@#$%^&*()_|+\-=?;:'",”“<>\{\}\[\]\\\/]/gi, "")
    .replace(/\s\s+/g, " ")
    .trim();
  const sentences = _payload.split(".");
  // return sentences;
  return excludeShortSentences(sentences, 10);
};

const removeDuplicates_ = (arr: string[], minLength: number = -1) => {
  return arr
    .filter((item) => minLength < 0 || item.length > minLength)
    .filter((item, index) => arr.indexOf(item) === index);
};

const excludeShortSentences = (arr: string[], minLength: number = -1) => {
  return arr.filter((item) => minLength < 0 || item.length > minLength);
};

export const updatePreset = async (data: any, userId?: string) => {
  const model = getCollection(presetCollection, presetSchema);
  let response = null;
  const corpusDecoded = await getCorpusDecoded(data.type, data.corpus);
  if (data._id) {
    response = await model.findByIdAndUpdate(
      data._id,
      { ...data, corpusDecoded, updatedBy: userId },
      { new: true, upsert: true }
    );
  } else {
    response = await model.create({
      ...data,
      corpusDecoded,
      createdBy: userId,
      updatedBy: userId,
    });
  }
  return await getPreset(userId);
};

const getCorpusDecoded = async (
  type: "Word" | "Sentence" | "AI",
  corpus: string
) => {
  switch (type) {
    case "Word":
      return findUniqueWords(corpus);
    case "Sentence":
      return findUniqueSetences(corpus);
    case "AI":
      return await findSentencesUsingAi(corpus);
    default:
      break;
  }
};

export const getPreset = async (userId?: string) => {
  const model = getCollection(presetCollection, presetSchema);

  return await model
    .find({ createdBy: { $in: [userId, null] } })
    .select("_id name type corpus createdBy")
    .sort({ name: "ascending" });
};

export const getPresetById = async (presetId: string) => {
  const model = getCollection(presetCollection, presetSchema);

  const response = await model.find({ _id: presetId });

  if (response.length > 0) {
    return response[0];
  }

  return null;
};

export const deletePreset = async (_id: string) => {
  const model = getCollection(presetCollection, presetSchema);

  await model.remove({ _id });
  return { preset: [_id] };
};

const findSentencesUsingAi = async (corpus: string) => {
  let items: string[] = [];
  let numberOfAiCalls = 0;
  while (numberOfAiCalls < 8 && items.length < AI_GENERATED_SENTENCE_COUNT) {
    console.log(`start - ${numberOfAiCalls}`);
    const batchOutput = await AiService.generate(corpus);
    items = items.concat(batchOutput);
    console.log(`finish - ${numberOfAiCalls}`);
    numberOfAiCalls++;
  }
  console.log(`Corpus generated in ${numberOfAiCalls} number of AI calls`);
  return items.slice(0, AI_GENERATED_SENTENCE_COUNT);
};
