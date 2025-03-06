import express from "express";
import {
    createReview,
    getReviewsByProduct,
    getReviewById,
    updateReview,
    deleteReview,
} from "../controllers/reviewController.js";

const reviewRouter = express.Router();

// Create a new review
reviewRouter.post("/", createReview);

// Get all reviews for a product
reviewRouter.get("/product/:productId", getReviewsByProduct);

// Get a single review by ID
reviewRouter.get("/:reviewId", getReviewById);

// Update a review
reviewRouter.put("/:reviewId", updateReview);

// Delete a review
reviewRouter.delete("/:reviewId", deleteReview);

export default reviewRouter;