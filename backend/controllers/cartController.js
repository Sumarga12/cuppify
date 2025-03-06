import Cart from '../models/cartModel.js'; // Import Cart model
import fs from 'fs'; // Optional, if needed for image deletion

// Add item to cart
// Add item to cart
const addCart = async (req, res) => {
    const { userId, cartItems, total, grandTotal, discount = 0 } = req.body;

    // Generate a unique cartNo based on the existing carts
    const lastCart = await Cart.findOne().sort({ cartNo: -1 }); // Find the last cart by cartNo in descending order
    const cartNo = lastCart ? lastCart.cartNo + 1 : 1;  // If no cart exists, start at 1, otherwise increment the last cartNo

    const cart = new Cart({
        userId,
        cartItems,
        total,
        discount,
        grandTotal,
        status: 'active',
        cartNo,  // Include the generated cartNo
    });

    try {
        await cart.save();
        res.json({ success: true, message: 'Cart Created', data: cart });
    } catch (error) {
        console.log(error);
        res.json({ success: false, message: 'Error creating cart' });
    }
};


// List cart for a user
const listCart = async (req, res) => {
    const { userId } = req.query;  // Assuming you are passing userId as a query parameter

    try {
        const cart = await Cart.findOne({ userId, status: 'active' }).populate('cartItems.product', 'name price images');
        if (!cart) {
            return res.json({ success: false, message: 'Cart not found for this user' });
        }
        res.json({ success: true, data: cart });
    } catch (error) {
        console.log(error);
        res.json({ success: false, message: 'Error fetching cart' });
    }
};

// Remove an item from cart
const removeCartItem = async (req, res) => {
    const { cartId, productId } = req.body;  // Cart ID and Product ID to remove

    try {
        const cart = await Cart.findById(cartId);

        if (!cart) {
            return res.json({ success: false, message: 'Cart not found' });
        }

        // Filter out the cart item to remove it
        cart.cartItems = cart.cartItems.filter(item => item.product.toString() !== productId);

        // Recalculate total and grandTotal after removing item
        const total = cart.cartItems.reduce((sum, item) => sum + item.price * item.quantity, 0);
        const grandTotal = total - cart.discount;

        cart.total = total;
        cart.grandTotal = grandTotal;

        await cart.save();
        res.json({ success: true, message: 'Item removed from cart', data: cart });
    } catch (error) {
        console.log(error);
        res.json({ success: false, message: 'Error removing item from cart' });
    }
};

// Update cart (optional)
const updateCart = async (req, res) => {
    const { cartId, cartItems } = req.body;

    try {
        const cart = await Cart.findById(cartId);

        if (!cart) {
            return res.json({ success: false, message: 'Cart not found' });
        }

        // Update cart items and recalculate total and grandTotal
        cart.cartItems = cartItems;
        const total = cart.cartItems.reduce((sum, item) => sum + item.price * item.quantity, 0);
        const grandTotal = total - cart.discount;

        cart.total = total;
        cart.grandTotal = grandTotal;

        await cart.save();
        res.json({ success: true, message: 'Cart updated successfully', data: cart });
    } catch (error) {
        console.log(error);
        res.json({ success: false, message: 'Error updating cart' });
    }
};

export { addCart, listCart, removeCartItem, updateCart };
