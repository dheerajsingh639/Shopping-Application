const express = require("express");
const bcrypt = require("bcryptjs");
const router = express.Router();
const User = require("./schema");
const path = require("path");
const multer = require("multer");
const bannermodel = require("./ImageSchema");

//Disk storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./uploads");
  },
  filename: function (req, file, cb) {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const upload = multer({ storage });

// Helper function to hash passwords

const hashPassword = async (password) => {
  return await bcrypt.hash(password, 10);
};

// Helper function to compare passwords

const comparePassword = async (password, hashedPassword) => {
  return await bcrypt.compare(password, hashedPassword);
};

//////////////////////////////// Multer Image Upload API ////////////////////////////////////////////////

// Multer API

router.post("/banner", upload.single("fileToUpload"), async (req, res) => {
  try {
    console.log(req.body);
    console.log(req.file);

    const newBanner = await bannermodel.create({
      filename: req.file.filename,
      filepath: req.file.path,
    });

    await newBanner.save();

    // Respond with success HTML page
    res.json({ msg: req.file.path });
    res.sendFile(path.join(__dirname, "public", "succes.html"));
  } catch (error) {
    console.error("Error uploading file:", error);
    res.status(500).send("An error occurred while uploading the file.");
  }
});

//////////////////////////////////////////Image find api ///////////////////////////////////////////////////////

router.get("/imageGet", async (req, res) => {
  try {
    const images = await bannermodel.find({});

    if (images.length > 0) {
      // Construct full URLs for all images
      const imageUrls = images.map((image) => {
        return req.protocol + "://" + req.get("host") + "/" + image.filepath;
      });

      res.json(imageUrls); // Send all image URLs as a JSON array
    } 
    
    else {
      res.status(404).send({ error: "No images found" });
    }
  }
  
  catch (error) {
    console.error("Error fetching images:", error);
    res.status(500).send({ error: "Internal server error" });
  }
});

////////////////////////////////REGISTER API //////////////////////////////////////////////////////

router.post("/register", async (req, res) => {
  const { name, email, password, mobile } = req.body;

  if (!name || !email || !password || !mobile) {
    return res.status(400).json({ msg: "All fields are required" });
  }

  try {
    const hashedPassword = await hashPassword(password);
    const result = await User.create({
      name,
      email,
      password: hashedPassword,
      mobile,
    });

    console.log("User created:", result); // Log the result for debugging
    return res.status(200).json({ msg: "User created successfully" });
  } catch (error) {
    console.error("Error creating user:", error.message);
    return res.status(500).json({ msg: "Internal Server Error" });
  }
});

///////////////////////////////////////////// LOGIN API ///////////////////////////////////////////////////////

router.post("/login", async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ msg: "Email and password are required" });
  }

  try {
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).json({ msg: "User not found" });
    }

    const isMatch = await comparePassword(password, user.password);

    if (isMatch) {
      // Redirect or send success message
      res.sendFile(path.join(__dirname, "public", "succes.html"));
      // res.status(200).json({ msg: "Login successful" });
    } else {
      return res.status(400).json({ msg: "Invalid credentials" });
    }
  } catch (error) {
    console.error("Error logging in:", error.message);
    return res.status(500).json({ msg: "Internal Server Error" });
  }
});

//////////////////////////////////////////////HOME ROUT /////////////////////////////////////////////////////

// Home Route
router.get("/home", (req, res) => {
  res.render("1.1home.ejs", {
    title: "Home",
  });
});

// Login Page Route
router.get("/login", (req, res) => {
  res.render("2.1login.ejs", {
    title: "Login",
  });
});

// Register Page Route
router.get("/register", (req, res) => {
  res.render("2.2Register.ejs", { title: "Register" });
});

// User Table Page Route
router.get("/userTable", async (req, res) => {
  try {
    const users = await User.find(); // Fetch all users from the database
    res.render("3.1userTable.ejs", { users }); // Pass the users data to the template
  } catch (err) {
    console.error("Error fetching users:", err);
    res.status(500).send("Server Error");
  }
});

// banners Page Route
router.get("/banner", async (req, res) => {
  try {
    const banners = await bannermodel.find();
    console.log("Fetched banners:", banners);

    res.render("4.1banner.ejs", { banners });
  } catch (error) {
    console.error("Error fetching banners:", error);
    res.status(500).send("An error occurred while fetching the banners.");
  }
});

// PopularProducts Page Route
router.get("/popularproducts", (req, res) => {
  res.render("5.1PopularProduts.ejs", {
    title: "popularproducts",
  });
});

// SuperFlashSale Page Route
router.get("/superflashsale", (req, res) => {
  res.render("6.1SuperFlashSale.ejs", {
    title: "superflashsale",
  });
});

// FlashSale.ejs Page Route
router.get("/flashsale", (req, res) => {
  res.render("7.1FlashSale.ejs", {
    title: "flashsale",
  });
});

// NewArrival Page Route
router.get("/newarrival", (req, res) => {
  res.render("8.1NewArrival.ejs", {
    title: "newarrival",
  });
});

// BestSaller Page Route
router.get("/bestsaller", (req, res) => {
  res.render("9.1BestSaller.ejs", {
    title: "bestsaller",
  });
});

// MostPopulerSaller Page Route
router.get("/mostpopulersaller", (req, res) => {
  res.render("10.1MostPopulersaller.ejs", {
    title: "mostpopulersaller",
  });
});

// BlackFriday Page Route
router.get("/blackfriday", (req, res) => {
  res.render("11.1blackFriday.ejs", {
    title: "blackfriday",
  });
});

module.exports = router;
