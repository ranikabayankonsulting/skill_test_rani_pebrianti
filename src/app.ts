import express from 'express';
import authRoutes from './routes/auth.routes';
import productRoutes from './routes/product.routes';
import integrationRoutes from './routes/integration.routes';
import reportRoutes from './routes/report.routes';
import customersRoutes from './routes/customers.routes';
import dotenv from 'dotenv';
dotenv.config();
import { errorHandler } from './middlewares/errorHandler';

const app = express();

app.use(express.json());

app.use('/auth', authRoutes);
app.use('/product', productRoutes);
app.use('/integration', integrationRoutes);
app.use('/report', reportRoutes);
app.use('/customers', customersRoutes);


app.use(errorHandler);

export default app;