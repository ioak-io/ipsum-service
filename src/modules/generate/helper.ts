import { capitalize } from 'lodash';
import * as corpusLorem from './corpus_lorem';
import * as corpusExpanded from './corpus_expanded';
import * as PresetHelper from '../preset/helper';

export const generateTextForPreset = async (
  presetId: string,
  type: string,
  count: number,
  batchSize: number
) => {

  const preset = await PresetHelper.getPresetById(presetId);

  const data: string[] = preset.corpusDecoded;

  const response: string[][] = [];
  if (type.toLowerCase() === "paragraph") {
    for (let j = 0; j < batchSize; j++) {
      let _texts: string[] = [];
      for (let i = 0; i < count; i++) {
        _texts.push(_getParagraph(preset.type, data, data.length));
      }
      response.push(_texts);
    }
  } else {
    for (let j = 0; j < batchSize; j++) {
      let _texts: string[] = [];
      for (let i = 0; i < count; i++) {
        _texts.push(_getSentence(preset.type, data, data.length));
      }
      response.push(_texts);
    }
  }
  return response;
};

export const generateText = async (
  language: "english",
  corpus: "lorem" | "expanded",
  type: string,
  count: number,
  batchSize: number
) => {

  const data: string[] = corpus === "lorem" ? corpusLorem[language] : corpusExpanded[language];

  const response: string[][] = [];
  if (type.toLowerCase() === "paragraph") {
    for (let j = 0; j < batchSize; j++) {
      let _texts: string[] = [];
      for (let i = 0; i < count; i++) {
        _texts.push(_getParagraph('Word', data, data.length));
      }
      response.push(_texts);
    }
  } else {
    for (let j = 0; j < batchSize; j++) {
      let _texts: string[] = [];
      for (let i = 0; i < count; i++) {
        _texts.push(_getSentence('Word', data, data.length));
      }
      response.push(_texts);
    }
  }
  return response;
};

const _getWord = (data: string[], size: number): string => {
  return data[Math.floor(Math.random() * size)];
}

const _getSentence = (inputUnit: 'Word' | 'Sentence' | 'AI', data: string[], size: number): string => {
  if (inputUnit === 'AI' || 'Sentence') {
    return data[Math.floor(Math.random() * size)] + ".";
  }

  let response = "";
  const count = _getRandomInt(7, 15);
  for (let i = 0; i < count; i++) {
    if (i > 0) response += " ";
    response += _getWord(data, size);
  }
  return capitalize(response + ".");
}

const _getParagraph = (inputUnit: 'Word' | 'Sentence' | 'AI', data: string[], size: number): string => {
  let response = "";
  const count = _getRandomInt(3, 10);
  for (let i = 0; i < count; i++) {
    if (i > 0) response += " ";
    response += _getSentence(inputUnit, data, size);
  }
  return response;
}

function _getRandomInt(min: number, max: number) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min) + min); // The maximum is exclusive and the minimum is inclusive
}

export const findUniqueWords = (payload: string) => {
  const _payload = payload
    .replace(/[0123456789`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '')
    .replace(/\s\s+/g, ' ')
    .toLowerCase()
    .trim();
  const words = _payload.split(" ");
  return removeDuplicates_(words);
}

const removeDuplicates_ = (arr: string[]) => {
  return arr.filter((item,
    index) => arr.indexOf(item) === index);
}