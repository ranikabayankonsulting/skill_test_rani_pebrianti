import express from 'express';
import * as customersController from '../controllers/customers.controller';

const router = express.Router();

router.post('/', customersController.createCustomer);

export default router;
