/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  TouchableHighlight,
  Text,
  View,
  NativeModules: { ModuleA, ModuleB }
} = React;

var pointersTest = React.createClass({
  tryPointers () {
    ModuleA.send((err, pointer) => {
      ModuleB.receive(pointer, (err, size) => {
        console.log(err, size)
      })
    })
  },

  render () {
    return (
      <View style={styles.container}>
        <TouchableHighlight onPress={this.tryPointers}>
          <Text style={styles.instructions}>
            Press here and check console for image dimensions.
          </Text>
        </TouchableHighlight>
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('pointersTest', () => pointersTest);
