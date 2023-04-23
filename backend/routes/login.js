const express = require("express");
const route = express.Router();
const User = require("../schemas/userSchema");
const crypto = require("crypto");
const NodeRSA = require("node-rsa");
route.get("/", async (req, res) => {
  const { username, encryptedData } = req.body;
  const response = await User.findOne({ username: username });
  var privateKey = response["exportedPrivateKey"];

  const decryptedResult = crypto.privateDecrypt(
    {
      key: privateKey,
      // In order to decrypt the data, we need to specify the
      // same hashing function and padding scheme that we used to
      // encrypt the data in the previous step
      padding: crypto.constants.RSA_PKCS1_OAEP_PADDING,
      oaepHash: "sha256",
    },
    Buffer.from(encryptedData, "base64")
  );

  res.json({ result: decryptedResult });
});
module.exports = route;
