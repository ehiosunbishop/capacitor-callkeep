import { WebPlugin } from '@capacitor/core';

import type { CallKeepPlugin } from './definitions';

export class CallKeepWeb extends WebPlugin implements CallKeepPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async register(): Promise<void> {
    console.log('Not supported on web.');
    return;
  }
}
