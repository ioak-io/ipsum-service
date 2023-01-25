const multer = require("multer");
var upload = multer();
import { asyncHandler } from "../../handler";
import { authorizeApi, authorizeApiRead } from "../../middlewares";
import {
  generateText,
  findUniqueWords
} from "./service";

const selfRealm = 100;

module.exports = function (router: any) {
  router.get("/generate/:language/:corpus/:type/:count/:batchSize", asyncHandler(generateText));
  router.post("/generate/unique", asyncHandler(findUniqueWords));
};
