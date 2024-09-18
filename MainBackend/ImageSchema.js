const mongoose = require('mongoose');

const bannerSchema = new mongoose.Schema({
  filename: {
    type: String,
    required: true,
  },
  filepath: {
    type: String,
    required: true,
  },
  uploadDate: {
    type: Date,
    default: Date.now,
  },
});

const bannermodel = mongoose.model("Banner",bannerSchema);

module.exports = bannermodel;
