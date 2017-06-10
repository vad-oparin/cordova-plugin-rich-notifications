@objc(CordovaPluginRichNotifications) class CordovaPluginRichNotifications : CDVPlugin {
  @objc(echo:)
  func echo(command: CDVInvokedUrlCommand) {
    print("Hello Swift echo")
    
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    var msg = command.arguments[0] as? String ?? ""
    
    msg += " modified inside of plugin"

    if msg.characters.count > 0 {
      let toastController: UIAlertController =
      UIAlertController(
        title: "",
        message: msg,
        preferredStyle: .alert
      )

      self.viewController?.present(
        toastController,
        animated: true,
        completion: nil
      )

      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        toastController.dismiss(
          animated: true,
          completion: nil
        )
      }

      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: msg
      )
    }

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
  
  @objc(testNotification:)
  func testNotification(command: CDVInvokedUrlCommand) {
    print("Hello Swift testNotification")

    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let eventDateAsDate = command.arguments[0] as? Date ?? nil
    let eventDateAsString = command.arguments[1] as? String ?? ""
    print("Date as date: '%@'", eventDateAsDate ?? "default value")
    print("Date as string: '%@'", eventDateAsString)
    
    //let calendar = Calendar(identifier: .gregorian)
    //let components = calendar.dateComponents(in: .current, from: eventDate)
    //print("month: " + components.month + " day: " + components.day + " hour: " + components.hour + " minute: " + components.minute)

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      //messageAs: "passed " + components.minute + " minutes"
      messageAs: "passed "
    )

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
}