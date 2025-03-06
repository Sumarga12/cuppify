import mongoose from "mongoose";

const productSchema = new mongoose.Schema({
    name: {type: String,required: true},
    description: {type: String,required: true},
    sku: {type: String},
    price: {type: Number,required: true},
    calorie_count: {type: Number},
    images: {type: String},
    category: {type: String,required: true}
})

const productModel = mongoose.model.product || mongoose.model("product",productSchema);

export default productModel;