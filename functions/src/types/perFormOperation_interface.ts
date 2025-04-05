export interface PerformOperationInterface<TArgs extends unknown[], TResult> {
  operationName: string;
  userId: string;
  timestamp?: Date;
  operation: (...args: TArgs) => Promise<TResult> | TResult;
}
