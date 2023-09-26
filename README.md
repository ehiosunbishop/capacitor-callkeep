# callkeep

utilises a brand new iOS 10 framework CallKit and Android ConnectionService to make the life easier for VoIP developers using Capacitor

## Install

```bash
npm install callkeep
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`register()`](#register)
* [`addListener('registration', ...)`](#addlistenerregistration)
* [`addListener('callAnswered', ...)`](#addlistenercallanswered)
* [`addListener('callStarted', ...)`](#addlistenercallstarted)
* [`addListener('callEnded', ...)`](#addlistenercallended)
* [Interfaces](#interfaces)
* [Type Aliases](#type-aliases)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### register()

```typescript
register() => Promise<void>
```

--------------------


### addListener('registration', ...)

```typescript
addListener(eventName: 'registration', listenerFunc: (token: CallToken) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

| Param              | Type                                                                |
| ------------------ | ------------------------------------------------------------------- |
| **`eventName`**    | <code>'registration'</code>                                         |
| **`listenerFunc`** | <code>(token: <a href="#calltoken">CallToken</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

--------------------


### addListener('callAnswered', ...)

```typescript
addListener(eventName: 'callAnswered', listenerFunc: (callData: CallData) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

| Param              | Type                                                                 |
| ------------------ | -------------------------------------------------------------------- |
| **`eventName`**    | <code>'callAnswered'</code>                                          |
| **`listenerFunc`** | <code>(callData: <a href="#calldata">CallData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

--------------------


### addListener('callStarted', ...)

```typescript
addListener(eventName: 'callStarted', listenerFunc: (callData: CallData) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

| Param              | Type                                                                 |
| ------------------ | -------------------------------------------------------------------- |
| **`eventName`**    | <code>'callStarted'</code>                                           |
| **`listenerFunc`** | <code>(callData: <a href="#calldata">CallData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

--------------------


### addListener('callEnded', ...)

```typescript
addListener(eventName: 'callEnded', listenerFunc: (callData: CallData) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

| Param              | Type                                                                 |
| ------------------ | -------------------------------------------------------------------- |
| **`eventName`**    | <code>'callEnded'</code>                                             |
| **`listenerFunc`** | <code>(callData: <a href="#calldata">CallData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

--------------------


### Interfaces


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### CallToken

| Prop        | Type                | Description |
| ----------- | ------------------- | ----------- |
| **`value`** | <code>string</code> | VOIP Token  |


#### CallData

| Prop           | Type                                          | Description       |
| -------------- | --------------------------------------------- | ----------------- |
| **`id`**       | <code>string</code>                           | Call ID           |
| **`media`**    | <code><a href="#calltype">CallType</a></code> | Call Type         |
| **`name`**     | <code>string</code>                           | Call Display name |
| **`duration`** | <code>string</code>                           | Call duration     |


#### MessageCallData

| Prop             | Type                   |
| ---------------- | ---------------------- |
| **`type`**       | <code>'message'</code> |
| **`callbackId`** | <code>string</code>    |
| **`pluginId`**   | <code>string</code>    |
| **`methodName`** | <code>string</code>    |
| **`options`**    | <code>any</code>       |


#### ErrorCallData

| Prop        | Type                                                                                           |
| ----------- | ---------------------------------------------------------------------------------------------- |
| **`type`**  | <code>'js.error'</code>                                                                        |
| **`error`** | <code>{ message: string; url: string; line: number; col: number; errorObject: string; }</code> |


### Type Aliases


#### CallType

<code>'video' | 'audio'</code>


#### CallData

<code><a href="#messagecalldata">MessageCallData</a> | <a href="#errorcalldata">ErrorCallData</a></code>

</docgen-api>
