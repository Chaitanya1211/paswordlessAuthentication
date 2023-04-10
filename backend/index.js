const express = require("express");
require("dotenv").config();
require("./db/conn");

const registerRoute = require("./routes/register");
const loginRoute = require("./routes/login");
const app = express();
app.use(express.json());
app.use("/register", registerRoute);
app.use("/login", loginRoute);
app.get("/", (req, res) => {
  res.send("Hello");
});
app.listen(process.env.PORT, () => {
  //   console.log("App running");
  console.log(`Server running on http://localhost:${process.env.PORT}/`);
});
