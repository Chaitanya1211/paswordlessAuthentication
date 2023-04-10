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
      return res.status(422).json({ message: " user exists" });
    } else {
      return res.status(200).json({ message: " user does not exists" });
    }
  } catch (err) {
    res.send(err);
  }
});

route.post("/new", async (req, res) => {
  const { username, publicKey } = req.body;
  const user = new User({ username, publicKey });
  // do hashing here
  const newUser = user.save();

  if (newUser) {
    res.status(201).json({
      message: "User Registered Successfully",
      publicKey: publicKey,
    });
  } else {
    res.status(500).json({ message: "Failed" });
  }
});
module.exports = route;
