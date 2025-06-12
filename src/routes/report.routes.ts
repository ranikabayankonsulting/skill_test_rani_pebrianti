import express from 'express';
import * as reportController from '../controllers/report.controller';

const router = express.Router();

router.get('/top-customers', reportController.topCustomers);
router.get('/top-customers-usd', reportController.topCustomersUsd);
router.get('/invoice-summary/:id', reportController.getInvoiceSummary);

export default router;