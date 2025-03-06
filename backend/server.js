import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

// Load environment variables from config.env
dotenv.config({ path: './config.env' });

// Debug: Log environment variables to verify they are loaded correctly
console.log("MONGO_URI:", process.env.MONG1O_URI);
console.log("JWT_SECRET:", process.env.JWT_SECRET);

import { connectDB } from './config/db.js';
import productRouter from './routes/productRoute.js';
import userRouter from './routes/userRoute.js';
import cartRouter from './routes/cartRoute.js';
import orderRouter from './routes/orderRoute.js';
import categoryRouter from './routes/categoryRoute.js';
import reviewRouter from "./routes/reviewRoute.js";

// App configuration
const app = express();
const port = process.env.PORT || 6000;

// Middleware
app.use(express.json());
app.use(cors());

// Connect to MongoDB (ensure MONGO_URI is set in config.env)
connectDB();

app.use('/uploads', express.static('uploads')); //Endpoint for Image Location


// API Endpoints
app.use("/api/products", productRouter);
// app.use("/images", express.static('uploads'));
app.use("/api/user", userRouter);
app.use("/api/review", reviewRouter);
app.use("/api/cart", cartRouter);
app.use("/api/order", orderRouter);
app.use("/api/categories", categoryRouter);


// Root endpoint
app.get("/", (req, res) => {
  res.send("API working");
});

// Start server
app.listen(port, () => {
  console.log(`Server started on http://localhost:${port}`);
});
