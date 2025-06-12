import express from 'express';
import * as integrationController from '../controllers/integration.controller';

const router = express.Router();

router.get('/usd-rate', integrationController.getUsdRate);
router.get('/usd-convert', integrationController.convertIdrToUsd); // tambahkan ini


export default router;