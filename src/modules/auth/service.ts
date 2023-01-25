import bcrypt from "bcrypt";
import { validateMandatoryFields } from "../../lib/validation";

import * as Helper from "./helper";
import { getCollection } from "../../lib/dbutils";
import { userCollection } from "../user/model";
import { comparePassword } from "../../lib/authutils";

const selfRealm = 100;

export const otrs = async (req: any, res: any, next: any) => {
  const payload = req.body;
  console.log("****OTRS****");
  console.log(payload);
  res.status(200);
  res.end();
}
