import express from 'express';
import * as authController from '../controllers/auth.controller';

const router = express.Router();

router.post('/register', authController.register); 
router.post('/login', authController.loginWithEmail);
router.post('/login/token', authController.loginWithToken);

export default router;