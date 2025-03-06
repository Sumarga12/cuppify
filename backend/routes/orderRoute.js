import express from "express";
import authMiddleware from './../middleware/auth.js';
import { placeOrder, verifyOrder, userOrders, listOrders, updateStatus } from "../controllers/orderController.js";

const orderRouter = express.Router();

// Protected route to place an order; order will be confirmed upon validation.
orderRouter.post("/place", authMiddleware, placeOrder);

// This endpoint now simply informs that payment verification is not required.
// You may remove this route if it's no longer needed.
orderRouter.post("/verify", verifyOrder);

// Protected route to fetch orders for a specific user.
orderRouter.post("/userorders", authMiddleware, userOrders);

// Public route to list all orders (for admin panel; consider adding authentication for admin access).
orderRouter.get('/list', listOrders);

// Route to update order status (typically used by admin; consider adding appropriate authentication).
orderRouter.post('/status', updateStatus);

export default orderRouter;
