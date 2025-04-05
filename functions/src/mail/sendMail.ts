/* eslint-disable max-len */
import { Request, Response } from 'express';
import nodemailer from 'nodemailer';
import { EmailInterface } from '../types/email_type';
import { mailUser, mailPassword } from '../config';
import { logger } from 'firebase-functions';
import { getRandomHaloPhrase, getRandomStoicQuote } from './phrases';



// Cloud Function
export const sendMailService = async ({
  req,
  res,
  body,
}: {
  req: Request;
  res: Response;
  body: EmailInterface;
}) => {
  if (req.method !== 'POST') {
    return res.status(405).send('Método no permitido');
  }
  if (!body) {
    return res.status(400).send('Falta el cuerpo de la solicitud');
  }

  if (!body.email || !body.email.includes('@')) {
    return res.status(400).send('Falta el correo electrónico o no es inválido');
  }

  if (!body.message) {
    return res.status(400).send('Falta el mensaje');
  }



  const halo = getRandomHaloPhrase();
  const stoic = getRandomStoicQuote();

  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: mailUser.value(),
      pass: mailPassword.value(),
    },
  });


  // 📥 Email para Rodrigo
  const adminHtml = `
 <div style="background-color: #0d0d0d; color: #00ffcc; font-family: monospace; padding: 20px; border-radius: 8px;">
   <h2>📡 NUEVA SEÑAL ENTRANTE</h2>
   <p><strong>Correo:</strong> ${body.email}</p>
   ${body.phone ? `<p><strong>Teléfono:</strong> ${body.phone}</p>` : ''}
   ${body.location ? `<p><strong>Ubicación:</strong> ${body.location}</p>` : ''}
   <p><strong>Mensaje:</strong></p>
   <pre style="background: #111; padding: 10px; border-left: 2px solid #00ffcc;">${body.message}</pre>
   <hr style="margin-top: 20px; border-color: #00ffcc;" />
   <p style="font-size: 12px; opacity: 0.6;">Transmisión recibida a través del HUD Web Spartan.</p>
 </div>
`;

  try {
    await transporter.sendMail({
      from: `"Cortana" <${process.env.EMAIL_USER}>`,
      to: mailUser.value(),
      subject: '✔️ Confirmación: Tu mensaje fue recibido',
      html: adminHtml,
    });

    logger.info(`Correo enviado a ${body.email}`);
  } catch (error) {
    logger.error('Error al enviar el correo:', error);
    res.status(500).send('Error al enviar el correo');
  }

  const confirmHtml = `
      <div style="background-color: #0f0f0f; color: #c3f3ff; font-family: monospace; padding: 20px; border-radius: 8px;">
        <h2>✔️ Transmisión Recibida</h2>
        <p>Tu señal ha sido interceptada correctamente por la IA Cortana.</p>
        <p>Un Spartan será enviado si la situación lo requiere.</p>
        <br />
        <strong>⚔️ Mensaje del campo de batalla:</strong><br/>
        <blockquote style="color: #00ffff; font-style: italic; margin: 12px 0;">"${halo}"</blockquote>

        <strong>🧠 Frase para tu espíritu:</strong><br/>
        <blockquote style="color: #ffd700; font-style: italic; margin: 12px 0;">"${stoic}"</blockquote>

        <hr style="margin-top: 20px; border-color: #333;" />
        <p style="font-size: 12px; opacity: 0.6;">HUD Web Spartan • Cortana AI v1.0</p>
      </div>
    `;

  try {
    await transporter.sendMail({
      from: `"Cortana" <${mailUser.value()}>`,
      to: body.email,
      subject: '✔️ Confirmación: Tu mensaje fue recibido',
      html: confirmHtml,
    });

    logger.info(`Correo enviado a ${body.email}`);
  } catch (error) {
    logger.error('Error al enviar el correo:', error);
    res.status(500).send('Error al enviar el correo');
  }

  res.status(200).send('Correo enviado');
  return;
};
