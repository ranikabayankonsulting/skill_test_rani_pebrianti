import express from 'express';
import * as productController from '../controllers/product.controller';

const router = express.Router();

router.post('/invoice', productController.createInvoice);

export default router;