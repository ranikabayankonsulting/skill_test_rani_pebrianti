import { db } from '../db/mysql';
import { Request, Response, NextFunction } from 'express';

export const createCustomer = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { name, email, phone } = req.body;

    const [result] = await db.query<any>(
      'INSERT INTO customers (name, email, phone) VALUES (?, ?, ?)',
      [name, email, phone]
    );

    const customer_id = result.insertId;

    res.json({ message: 'Customer created successfully', customer_id });
  } catch (err) {
    next(err);
  }
};
