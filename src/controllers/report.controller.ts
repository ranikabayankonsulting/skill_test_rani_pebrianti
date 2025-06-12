import { db } from '../db/mysql';
import fetch from 'node-fetch';
import { Request, Response, NextFunction } from 'express';

// Load env variable
const baseUrl = process.env.INTEGRATION_API_BASE_URL;

// Define response type dari /integration/usd-rate
interface UsdRateResponse {
  rate: number;
}

// Helper function → ambil USD rate dari integration endpoint
const getUsdRate = async (): Promise<number> => {
  const response = await fetch(`${baseUrl}/integration/usd-rate`);
  const rateData = await response.json() as unknown as UsdRateResponse;
  return rateData.rate;
};

// ✅ Laporan: Customer dengan pembelian terbanyak (IDR saja)
export const topCustomers = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const [rows] = await db.query<any[]>(`
      SELECT i.customer_id, SUM(ii.qty * ii.price) AS total_idr
      FROM invoices i
      JOIN invoice_items ii ON i.id = ii.invoice_id
      GROUP BY i.customer_id
      ORDER BY total_idr DESC
      LIMIT 10
    `);

    res.json(rows);
  } catch (err) {
    next(err);
  }
};


export const topCustomersUsd = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const [rows] = await db.query<any[]>(`
      SELECT i.customer_id, SUM(ii.qty * ii.price) AS total_idr
      FROM invoices i
      JOIN invoice_items ii ON i.id = ii.invoice_id
      GROUP BY i.customer_id
      ORDER BY total_idr DESC
      LIMIT 10
    `);

    // Ambil USD rate pakai helper
    const usdToIdrRate = await getUsdRate();

    if (!usdToIdrRate) {
      throw new Error('Failed to get USD to IDR rate from integration endpoint');
    }

    // Konversi total_idr ke total_usd
    const report = rows.map(row => ({
      customer_id: row.customer_id,
      total_idr: row.total_idr,
      total_usd: (row.total_idr / usdToIdrRate).toFixed(2)
    }));

    res.json({
      usd_to_idr_rate: usdToIdrRate,
      report
    });
  } catch (err) {
    next(err);
  }
};



export const getInvoiceSummary = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;

    const [rows] = await db.query<any[]>(`
      SELECT SUM(qty * price) AS total_idr
      FROM invoice_items
      WHERE invoice_id = ?
    `, [id]);

    const total_idr = rows[0].total_idr || 0;

    // Ambil USD rate pakai helper
    const usdToIdrRate = await getUsdRate();

    const total_usd = total_idr / usdToIdrRate;

    res.json({
      invoice_id: id,
      total_idr,
      usd_to_idr_rate: usdToIdrRate,
      total_usd: total_usd.toFixed(2)
    });
  } catch (err) {
    next(err);
  }
};
