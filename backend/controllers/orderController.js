import orderModel from './../models/orderModel.js';
import userModel from './../models/userModel.js';

// Placing user order for frontend without using Stripe
const placeOrder = async (req, res) => {
  try {
    // Extract order details from request body
    const { userId, items, amount, address } = req.body;
    
    // Basic form validation
    if (!userId || !items || items.length === 0 || !amount || !address) {
      return res.status(400).json({ success: false, message: "Missing required order fields." });
    }

    // Create a new order with confirmed status (since no payment gateway is used)
    const newOrder = new orderModel({
      userId,
      items,
      amount,
      address,
      payment: true,           // Mark as paid/confirmed
      status: "confirmed",     // Order confirmed
      createdAt: new Date()
    });

    // Save the order and clear user's cart
    await newOrder.save();
    await userModel.findByIdAndUpdate(userId, { cartData: {} });

    res.status(201).json({ success: true, message: "Order confirmed", order: newOrder });
  } catch (error) {
    console.log("Error placing order:", error);
    res.status(500).json({ success: false, message: "Error processing order." });
  }
};

// Since we're no longer using Stripe for payment, verifyOrder is simplified
const verifyOrder = async (req, res) => {
  res.status(400).json({ success: false, message: "Payment verification is not required. Order is confirmed upon submission." });
};

// Retrieve orders for a specific user
const userOrders = async (req, res) => {
  try {
    const orders = await orderModel.find({ userId: req.body.userId });
    res.status(200).json({ success: true, data: orders });
  } catch (error) {
    console.log("Error fetching user orders:", error);
    res.status(500).json({ success: false, message: "Error fetching user orders." });
  }
};

// List all orders (for admin panel)
const listOrders = async (req, res) => {
  try {
    const orders = await orderModel.find({});
    res.status(200).json({ success: true, data: orders });
  } catch (error) {
    console.log("Error fetching orders:", error);
    res.status(500).json({ success: false, message: "Error fetching orders." });
  }
};

// Update order status (admin functionality)
const updateStatus = async (req, res) => {
  try {
    const { orderId, status } = req.body;
    await orderModel.findByIdAndUpdate(orderId, { status });
    res.status(200).json({ success: true, message: "Status Updated" });
  } catch (error) {
    console.log("Error updating order status:", error);
    res.status(500).json({ success: false, message: "Error updating order status." });
  }
};

export { placeOrder, verifyOrder, userOrders, listOrders, updateStatus };
