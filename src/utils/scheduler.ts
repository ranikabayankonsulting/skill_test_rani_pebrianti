import cron from 'node-cron';

export const startScheduler = () => {
  // Contoh task: log message setiap 10 detik
  cron.schedule('*/10 * * * * *', () => {
    console.log(`[Scheduler] Running task at ${new Date().toISOString()}`);
  });
};
