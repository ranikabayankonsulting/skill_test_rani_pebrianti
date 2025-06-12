import { Request, Response, NextFunction } from 'express';
import dotenv from 'dotenv';
dotenv.config();

export const getUsdRate = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const response = await fetch('https://api.exchangerate-api.com/v4/latest/USD');
    const data = await response.json();

    res.json({ rate: data.rates.IDR });
  } catch (err) {
    next(err);
  }
};

export const convertIdrToUsd = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { amount } = req.query;

    if (!amount || isNaN(Number(amount))) {
      throw new Error('Amount parameter is required and must be a number');
    }

    const response = await fetch('https://api.exchangerate-api.com/v4/latest/USD');
    const data = await response.json();

    const usdToIdrRate = data.rates.IDR;

    if (!usdToIdrRate) {
      throw new Error('Failed to get USD to IDR rate');
    }

    const amount_idr = Number(amount);
    const amount_usd = amount_idr / usdToIdrRate;

    res.json({
      amount_idr,
      amount_usd: amount_usd.toFixed(2),
      usd_to_idr_rate: usdToIdrRate
    });
  } catch (err) {
    next(err);
  }
};
