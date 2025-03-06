import express from 'express';
import { addCart, listCart, removeCartItem, updateCart } from '../controllers/cartController.js';

const cartRouter = express.Router();

// Add cart
cartRouter.post('/add', addCart);

// List user's cart (get cart by userId)
cartRouter.get('/my-cart', listCart);  // Endpoint for getting user's cart

// Remove an item from cart
cartRouter.post('/add-remove-item', removeCartItem);  // Endpoint to remove item from cart

// Update cart (if you need to allow updates to cart items)
cartRouter.post('/update', updateCart);  // Endpoint for updating cart

export default cartRouter;
