import express from 'express';
import {
    loginUser,
    registerUser,
    getUserById,
    getUserByEmail,
    updateUserPut,
    updateUserPatch
} from '../controllers/userController.js';

const userRouter = express.Router();

userRouter.post('/register', registerUser);
userRouter.post('/login', loginUser);

// Get user by ID
userRouter.get('/:id', getUserById);

// Get user by Email
userRouter.get('/email/:email', getUserByEmail);

// Update user (full update with PUT)
userRouter.put('/:id', updateUserPut);

// Update user (partial update with PATCH)
userRouter.patch('/update-profile/:id', updateUserPatch);

export default userRouter;
