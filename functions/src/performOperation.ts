import { logger } from 'firebase-functions';

/**
 * Ejecuta una función con manejo centralizado de logs y errores.
 * @template TArgs - Tipo de los argumentos que acepta la función.
 * @template TResult - Tipo del valor que retorna la función.
 * @param functionName - Nombre de la función a ejecutar (para logging).
 * @param userId - ID del usuario que realiza la operación.
 * @param operation - Función a ejecutar.
 * @param args - Argumentos para pasar a la función.
 * @return El resultado de la operación o undefined si falla.
 */
export async function performOperation<TArgs extends unknown[], TResult>(
  functionName: string,
  userId: string,
  operation: (...args: TArgs) => Promise<TResult> | TResult,
  ...args: TArgs
): Promise<TResult | undefined> {
  const timestamp = new Date();
  const user = userId || 'anonymous';

  try {
    logger.info(
      `[${timestamp.toISOString()}] ⏳ Ejecutando función: ${functionName} por ${user}`,
    );
    const result = await operation(...args);
    logger.info(
      `[${timestamp.toISOString()}] ✅ Función completada: ${functionName}`,
    );
    return result;
  } catch (error) {
    logger.error(
      `[${timestamp.toISOString()}] ❌ Error en ${functionName}`,
      error,
    );
    return undefined;
  }
}