import { db } from '../db/mysql';
import { Request, Response, NextFunction } from 'express';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';


export const register = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { email, password } = req.body;

    // Cek apakah email sudah ada
    const [rows] = await db.query<any[]>('SELECT * FROM users WHERE email = ?', [email]);
    if (rows.length > 0) throw new Error('Email already registered');

    // Hash password
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    // Simpan user ke DB
    await db.query('INSERT INTO users (email, password) VALUES (?, ?)', [email, hashedPassword]);

    res.json({ message: 'User registered successfully' });
  } catch (err) {
    next(err);
  }
};


export const loginWithEmail = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { email, password } = req.body;
    const [rows] = await db.query<any[]>('SELECT * FROM users WHERE email = ?', [email]);

    if (rows.length === 0) throw new Error('User not found');

    const isMatch = await bcrypt.compare(password, rows[0].password);

    if (!isMatch) throw new Error('Invalid password');

    const payload = {
      userId: rows[0].id,
      email: rows[0].email
    };
  const token = jwt.sign(payload, 'SECRET_KEY', { expiresIn: '1h' });
  res.json({ token });
  } catch (err) {
    next(err);
  }
};

export const loginWithToken = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { token } = req.body;

    if (!token) throw new Error('Token is required');
    const payload = jwt.verify(token, 'SECRET_KEY');

    res.json({ message: 'Login success via token', payload });
  } catch (err) {
    next(err);
  }
};