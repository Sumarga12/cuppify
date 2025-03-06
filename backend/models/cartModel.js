import mongoose from "mongoose";

const cartItemSchema = new mongoose.Schema({
    product: { // Changed from 'item' to 'product'
        type: mongoose.Schema.Types.ObjectId,
        ref: 'product',
        required: true,
    },
    price: {
        type: Number,
        required: true,
    },
    quantity: {
        type: Number,
        required: true,
    },
});

const cartSchema = new mongoose.Schema({
    cartNo: {
        type: Number,
        required: false,
        unique: true,
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'user',
        required: true,
    },
    total: {
        type: Number,
        required: true,
    },
    discount: {
        type: Number,
        default: 0,
    },
    grandTotal: {
        type: Number,
        required: true,
    },
    status: {
        type: String,
        default: 'active',
    },
    cartItems: [cartItemSchema],
}, { timestamps: true });

const Cart = mongoose.model('cart', cartSchema);

export default Cart; // Use 'export default' instead of 'module.exports'
