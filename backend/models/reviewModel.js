import mongoose from "mongoose";

const reviewSchema = new mongoose.Schema({
    product: { type: String, required: true }, // Product ID
    user: { type: mongoose.Schema.Types.ObjectId, ref: "user", required: true }, // User ID (reference to the User model)
    rating: { type: Number, required: true, min: 1, max: 5 }, // Rating (1-5)
    message: { type: String, required: true }, // Review message
    createdAt: { type: Date, default: Date.now }, // Timestamp
    updatedAt: { type: Date, default: Date.now }, // Timestamp
});

// Update the `updatedAt` field before saving
reviewSchema.pre("save", function (next) {
    this.updatedAt = Date.now();
    next();
});

const ReviewModel = mongoose.models.review || mongoose.model("review", reviewSchema);

export default ReviewModel;