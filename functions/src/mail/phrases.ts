
export const haloPhrases = [
    'Estoy en camino. El anillo está inestable. Necesito extracción.',
    'La señal está comprometida. Reestableciendo contacto.',
    'El protocolo Cole ha sido activado. Transmisión prioritaria.',
    'Requiriendo refuerzo orbital inmediato.',
    'Base Echo ha caído. Buscando coordenadas alternativas.',
    'Iniciando protocolo de evacuación clase-7.',
    'Confirmado: presencia hostil en la zona.',
    'Frecuencia Spartan establecida. Esperando respuesta.',
    'Reactor al 30%. Contacto antes del colapso.',
    'Acceso bloqueado. Necesito override desde el núcleo.',
    'Prioridad Alfa. Transmisión de emergencia iniciada.',
    'Aquí Cortana. La señal fue recibida.',
    'Jefe, los sistemas están en línea. Te estamos siguiendo.',
    'Los anillos siempre mienten. Mantente alerta.',
    'La batalla no ha terminado, Spartan. Apenas comienza.',
];

export const stoicQuotes = [
    'La felicidad de tu vida depende de la calidad de tus pensamientos. – Marco Aurelio',
    'Elige no ser lastimado y no te sentirás lastimado. – Marco Aurelio',
    'No nos afecta lo que nos sucede, sino lo que nos decimos sobre lo que nos sucede. – Epicteto',
    'El dolor es inevitable, el sufrimiento es opcional.',
    'La adversidad revela al genio, la prosperidad lo oculta. – Horacio',
    'Cuanto más sudas en el entrenamiento, menos sangras en la batalla.',
    'Haz lo que debas, y deja que suceda lo que pueda. – Marco Aurelio',
    'Nada grande se ha logrado sin esfuerzo. – Séneca',
    'No te preocupes por las cosas que no puedes controlar. – Epicteto',
    'La dificultad muestra lo que los hombres son. – Epicteto',
    'Aquel que ha superado sus miedos será verdaderamente libre. – Aristóteles',
    // eslint-disable-next-line max-len
    'El valor no es la ausencia de miedo, sino el juicio de que hay algo más importante. – Ambrose Redmoon',
    'Domina tu mente o ella te dominará a ti.',
    'No reces por una vida fácil, reza por la fuerza para soportar una difícil. – Bruce Lee',
    'Cuida más tu carácter que tu reputación. – John Wooden',
    'Haz lo correcto, aunque cueste.',
    'El estoico no es insensible, es imperturbable.',
    'El alma noble tiene calma en la tormenta.',
    'La disciplina es libertad.',
    'Sé más fuerte que tus excusas.',
    'El obstáculo es el camino. – Marco Aurelio',
    'Actúa con intención, no por impulso.',
    'El guerrero no se queja, se adapta.',
    'Una vez que conquistas tu interior, nada externo puede conquistarte.',
    'El tiempo que pierdes en quejarte, podrías usarlo en entrenar.',
    'Cuida tu mente, es tu verdadera fortaleza.',
    'El que se domina a sí mismo, es invencible.',
    'La victoria más grande es conquistarte a ti mismo. – Platón',
    'La mejor venganza es no parecerse al enemigo. – Marco Aurelio',
    'Tu vida es tu mensaje al mundo. Asegúrate que sea inspiradora.',
    'Lo que haces hoy construye el mañana.',
    'Nadie es libre si no es dueño de sí mismo. – Epicteto',
    'Resiste y persiste. – Epicteto',
    'Hazlo con miedo, pero hazlo.',
    'El hombre sabio es dueño de sus pasiones.',
    'No hay viento favorable para el que no sabe a dónde va. – Séneca',
    'Tu deber es actuar, no controlar el resultado. – Bhagavad Gita',
    'No temas al fracaso. Teme no intentarlo.',
    'Nunca subestimes el poder de una mente tranquila.',
    'Las cicatrices son el mapa de un guerrero.',
    'La calma es un superpoder.',
    'Vive como si ya fueras el héroe de tu historia.',
    'Aguanta. Resiste. Vuelve a intentarlo.',
    'El deber llama, y el Spartan responde.',
    'Nada que valga la pena es fácil.',
    'Tu mente es el campo de batalla. Defiéndela.',
    'No hay atajos a donde vale la pena ir.',
    'La gloria es para los que luchan cuando nadie los ve.',
    'No es el momento de rendirse. Es el momento de resistir.',
    'Spartan, tú eres la última esperanza.',
];

export function getRandomHaloPhrase() {
    return haloPhrases[Math.floor(Math.random() * haloPhrases.length)];
}

export function getRandomStoicQuote() {
    return stoicQuotes[Math.floor(Math.random() * stoicQuotes.length)];
}
