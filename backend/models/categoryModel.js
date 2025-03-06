import mongoose from "mongoose";

const categorySchema = new mongoose.Schema({
    name: {type: String,required: true},
    description: {type: String,required: true},
    isActive: {type: Boolean},
},{ timestamps: true })

const categoryModel = mongoose.model.category || mongoose.model("category",categorySchema);

export default categoryModel;