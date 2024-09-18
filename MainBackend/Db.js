const mongoose = require("mongoose");

const Db = () => {
  mongoose.connect('mongodb://localhost:27017/Data')
  .then(() => {
    console.log("Connected to MongoDB");
  }).catch((err) => {
    console.error("Error connecting to MongoDB:", err);
  });
};

module.exports = Db;
