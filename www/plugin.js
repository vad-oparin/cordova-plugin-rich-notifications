
var exec = require('cordova/exec');

var PLUGIN_NAME = 'CordovaPluginRichNotifications';

var CordovaPluginRichNotifications = {
  echo: function(phrase, cb) {
    exec(cb, null, PLUGIN_NAME, 'echo', [phrase]);
  },
  testNotification: function(eventAsDate, eventAsString, cb) {
    exec(cb, null, PLUGIN_NAME, 'testNotification', [eventAsDate, eventAsString]);
  },
  getDate: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'getDate', []);
  }
};

module.exports = CordovaPluginRichNotifications;
