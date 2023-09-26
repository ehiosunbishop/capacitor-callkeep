import { registerPlugin } from '@capacitor/core';

import type { CallKeepPlugin } from './definitions';

const CallKeep = registerPlugin<CallKeepPlugin>('CallKeep', {
  web: () => import('./web').then(m => new m.CallKeepWeb()),
});

export * from './definitions';
export { CallKeep };
