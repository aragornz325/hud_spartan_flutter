import { onRequest } from 'firebase-functions/v2/https';
import * as logger from 'firebase-functions/logger';
import { sendMailService } from './mail/sendMail';
import { Request, Response } from 'firebase-functions/v1';
import { EmailInterface } from './types/email_type';
import { performOperation } from './performOperation';
import cors from 'cors';

const corsMiddleware = cors({ origin: true });

export const sendEmail = onRequest((req:Request, res:Response) => {
  corsMiddleware(req, res, async () => {
    try {
      logger.info('🔄 Iniciando envío de correo');
      const body:EmailInterface = req.body;

      await performOperation(
        'enviar correo',
        'spartan-rmq-117',
        sendMailService,
        { req, res, body }
      );

      logger.info('✅ Correo enviado');
    } catch (error) {
      logger.error('❌ Error en sendEmail', error);
      res.status(500).send({ error: 'Error interno' });
    }
  });
});

export const helloWorld = onRequest((request, response) => {
  logger.info('👋 Hello from Firebase!');
  response.send('Hello from Firebase!');
});
