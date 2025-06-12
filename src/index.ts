import app from './app';
import { startScheduler } from './utils/scheduler';
import dotenv from 'dotenv';
dotenv.config();

const PORT = 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  startScheduler(); // Jalankan scheduler saat server start
});
