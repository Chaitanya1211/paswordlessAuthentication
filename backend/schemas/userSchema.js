const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  username: {
    type: String,
    unique: true,
    required: true,
  },
  publicKey: {
    type: String,
  },
});

module.exports = mongoose.model("User", userSchema);
