import ReviewModel from "../models/reviewModel.js";

// Create a new review
const createReview = async (req, res) => {
    const { product, user, rating, message } = req.body;

    try {
        const newReview = new ReviewModel({
            product,
            user,
            rating,
            message,
        });

        const savedReview = await newReview.save();
        res.status(201).json({ success: true, review: savedReview });
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, message: "Server error" });
    }
};

// Get all reviews for a product
const getReviewsByProduct = async (req, res) => {
    const { productId } = req.params;

    try {
        const reviews = await ReviewModel.find({ product: productId }).populate("user", "name email"); // Populate user details
        res.status(200).json({ success: true, reviews });
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, message: "Server error" });
    }
};

// Get a single review by ID
const getReviewById = async (req, res) => {
    const { reviewId } = req.params;

    try {
        const review = await ReviewModel.findById(reviewId).populate("user", "name email"); // Populate user details
        if (!review) {
            return res.status(404).json({ success: false, message: "Review not found" });
        }
        res.status(200).json({ success: true, review });
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, message: "Server error" });
    }
};

// Update a review
const updateReview = async (req, res) => {
    const { reviewId } = req.params;
    const { rating, message } = req.body;

    try {
        const updatedReview = await ReviewModel.findByIdAndUpdate(
            reviewId,
            { rating, message, updatedAt: Date.now() },
            { new: true }
        ).populate("user", "name email"); // Populate user details

        if (!updatedReview) {
            return res.status(404).json({ success: false, message: "Review not found" });
        }
        res.status(200).json({ success: true, review: updatedReview });
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, message: "Server error" });
    }
};

// Delete a review
const deleteReview = async (req, res) => {
    const { reviewId } = req.params;

    try {
        const deletedReview = await ReviewModel.findByIdAndDelete(reviewId);
        if (!deletedReview) {
            return res.status(404).json({ success: false, message: "Review not found" });
        }
        res.status(200).json({ success: true, message: "Review deleted successfully" });
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, message: "Server error" });
    }
};

export { createReview, getReviewsByProduct, getReviewById, updateReview, deleteReview };