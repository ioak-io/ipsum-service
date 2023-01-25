import { asyncHandler } from "../../handler";
import { authorizeApi } from "../../middlewares";
import {
  otrs
} from "./service";

const selfRealm = 100;

module.exports = function (router: any) {
  router.post("/otrs", asyncHandler(otrs));
};
