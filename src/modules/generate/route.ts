const multer = require("multer");
var upload = multer();
import { asyncHandler } from "../../handler";
import {
  generateText,
  generateTextForPreset,
  findUniqueWords
} from "./service";

const selfRealm = 100;

module.exports = function (router: any) {
  router.get("/generate/:language/:corpus/:type/:count/:batchSize", asyncHandler(generateText));
  router.get("/generate/:presetId/:type/:count/:batchSize", asyncHandler(generateTextForPreset));
  router.post("/generate/unique", asyncHandler(findUniqueWords));
};
