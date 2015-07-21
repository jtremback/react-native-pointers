# react-native-pointers

This allows you to use pointers in JS, for data that is in Objective C memory.

```js
ModuleA.send((err, pointer) => { // `pointer` is simply a string
  ModuleB.receive(pointer) // Module B does something with the data. The actual data never went over the bridge.
})
```
