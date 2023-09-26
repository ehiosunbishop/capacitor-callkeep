export interface CallKeepPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
