const mongoose = require("mongoose");

mongoose
  .connect(process.env.DB_URL, {
    useNewUrlParser: true,
  })
  .then(() => {
    console.log("Connection success");
  })
  .catch((err) => {
    console.log("Connection failed");
    console.log("Error :" + err);
  });
