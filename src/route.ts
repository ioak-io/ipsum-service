const express = require("express");
const router = express.Router();

router.get("/", (_: any, res: any) => {
  res.send("v1.0.0");
  res.end();
});

require("./modules/hello/route")(router);
require("./modules/generate/route")(router);
require("./modules/preset/route")(router);
require("./modules/auth/route")(router);
require("./modules/generate-paragraph/route")(router);

module.exports = router;
