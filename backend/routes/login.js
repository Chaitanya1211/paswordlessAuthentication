const express = require("express");
const route = express.Router();
const User = require("../schemas/userSchema");
const crypto = require("crypto");
const NodeRSA = require("node-rsa");
// route.get("/", (req, res) => {
//   res.send("Login page");
// });

route.get("/secret", async (req, res) => {
  const { username } = req.body;
  const response = await User.findOne({ username: username });
  var publicKey = response["publicKey"];
  console.log(publicKey);
  var public_key = new NodeRSA(publicKey);

  var encryptedData = public_key.encrypt(process.env.SECRET_KEY, "base64");
  res.json({ encryptedData: encryptedData });
});

route.get("/verify", (req, res) => {
  const { secret } = req.body;
  if (secret == process.env.SECRET_KEY) {
    res.json({ message: "Login success" });
  } else {
    res.json({ message: "login fail" });
  }
});
module.exports = route;
