import express from "express";
import { getAllCategories, addCategory, updateCategory, deleteCategory } from "../controllers/categoryController.js";

const router = express.Router();

router.get("/", getAllCategories); // Get all categories
router.post("/", addCategory); // Add new category
router.put("/:id", updateCategory); // Update a category
router.delete("/:id", deleteCategory); // Delete a category

export default router;
