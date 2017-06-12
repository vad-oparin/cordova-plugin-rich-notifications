
var exec = require('cordova/exec');

var PLUGIN_NAME = 'CordovaPluginRichNotifications';

var CordovaPluginRichNotifications = {
  sendNotification: function(eventAsString, cb) {
    exec(cb, null, PLUGIN_NAME, 'sendNotification', [eventAsString]);
  }
};

module.exports = CordovaPluginRichNotifications;
