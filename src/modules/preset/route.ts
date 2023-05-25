import { asyncHandler } from "../../handler";
import { authorizeApi, authorize, authorizeApiRead } from "../../middlewares";
import {
  updatePreset,
  getPreset,
  deletePreset,
} from "./service";

const selfRealm = 100;

module.exports = function (router: any) {
  router.put("/preset", authorizeApi, asyncHandler(updatePreset));
  router.get("/preset", authorizeApiRead, asyncHandler(getPreset));
  router.delete("/preset/:id", authorizeApi, asyncHandler(deletePreset));
};
