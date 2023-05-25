var mongoose = require("mongoose");

const Schema = mongoose.Schema;
const presetSchema = new Schema(
  {
    name: { type: String },
    type: { type: String },
    corpus: { type: String },
    corpusDecoded: { type: Array },
    createdBy: { type: String },
    updatedBy: { type: String },
  },
  { timestamps: true }
);

const presetCollection = "preset";

// module.exports = mongoose.model('bookmarks', articleSchema);
export { presetSchema, presetCollection };
