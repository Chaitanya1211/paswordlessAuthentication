const express = require("express");
const route = express.Router();
const User = require("../schemas/userSchema");
const crypto = require("crypto");
route.post("/check", async (req, res) => {
  // res.send("Hello registration");
  const { username } = req.body;
  try {
    const response = await User.findOne({ username: username });

    if (response) {
      return res.status(200).json({ message: "user exists" });
    } else {
      return res.status(200).json({ message: "user does not exists" });
    }
  } catch (err) {
    res.send(err);
  }
});

route.post("/new", async (req, res) => {
  const { username } = req.body;

  const { publicKey, privateKey } = crypto.generateKeyPairSync("rsa", {
    // The standard secure default length for RSA keys is 2048 bits
    modulusLength: 2048,
  });
  const exportedPublicKey = publicKey.export({
    type: "pkcs1",
    format: "pem",
  });

  const exportedPrivateKey = privateKey.export({
    type: "pkcs1",
    format: "pem",
  });

  const user = new User({ username, exportedPrivateKey });
  // do hashing here
  const newUser = user.save();

  if (newUser) {
    res.status(200).json({
      message: "User Registered Successfully",
      publicKey: exportedPublicKey,
    });
  } else {
    res.status(200).json({ message: "Failed" });
  }
});
module.exports = route;
