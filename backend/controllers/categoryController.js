import Category from "../models/categoryModel.js";

// Get all categories
const getAllCategories = async (req, res) => {
    try {
        const categories = await Category.find();
        res.status(200).json(categories);
    } catch (error) {
        res.status(500).json({ message: "Error fetching categories", error });
    }
};

// Add a new category
const addCategory = async (req, res) => {
    try {
        const { name, description, isActive } = req.body;
        const newCategory = new Category({ name, description, isActive });
        await newCategory.save();
        res.status(201).json({ message: "Category added successfully", category: newCategory });
    } catch (error) {
        res.status(500).json({ message: "Error adding category", error });
    }
};

// Update a category
const updateCategory = async (req, res) => {
    try {
        const { id } = req.params;
        const updatedCategory = await Category.findByIdAndUpdate(id, req.body, { new: true });
        if (!updatedCategory) return res.status(404).json({ message: "Category not found" });

        res.status(200).json({ message: "Category updated", category: updatedCategory });
    } catch (error) {
        res.status(500).json({ message: "Error updating category", error });
    }
};

// Delete a category
const deleteCategory = async (req, res) => {
    try {
        const { id } = req.params;
        const deletedCategory = await Category.findByIdAndDelete(id);
        if (!deletedCategory) return res.status(404).json({ message: "Category not found" });

        res.status(200).json({ message: "Category deleted successfully" });
    } catch (error) {
        res.status(500).json({ message: "Error deleting category", error });
    }
};

export { getAllCategories, deleteCategory, updateCategory, addCategory };
