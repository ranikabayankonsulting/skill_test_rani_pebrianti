import { db } from '../db/mysql';
import { Request, Response, NextFunction } from 'express';

export const createInvoice = async (req: Request, res: Response, next: NextFunction) => {
  const conn = await db.getConnection();
  await conn.beginTransaction();

  try {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, '');
    const prefix = `INV-${today}-`;

    const [result] = await conn.query<any[]>(`SELECT max_number FROM invoice_sequence WHERE date = ? FOR UPDATE`, [today]);

    let number = 1;

    if (result.length === 0) {
      await conn.query('INSERT INTO invoice_sequence (date, max_number) VALUES (?, ?)', [today, number]);
    } else {
      number = result[0].max_number + 1;
      await conn.query('UPDATE invoice_sequence SET max_number = ? WHERE date = ?', [number, today]);
    }

    const kode_invoice = `${prefix}${number.toString().padStart(3, '0')}`;

    // Destructure body
    const { customer_id, items } = req.body;

    // Validasi items
    if (!items || items.length === 0) {
      throw new Error('Invoice must have at least 1 item');
    }

    // Insert ke invoices table
    const [invoiceResult] = await conn.query<any>(
      'INSERT INTO invoices (kode_invoice, customer_id) VALUES (?, ?)',
      [kode_invoice, customer_id]
    );

    const invoice_id = invoiceResult.insertId;

    // Insert invoice_items
    for (const item of items) {
      await conn.query(
        'INSERT INTO invoice_items (invoice_id, product_name, qty, price) VALUES (?, ?, ?, ?)',
        [invoice_id, item.product_name, item.qty, item.price]
      );
    }

    await conn.commit();

    res.json({ kode_invoice });
  } catch (err) {
    await conn.rollback();
    next(err);
  } finally {
    conn.release();
  }
};
