import UserNotifications

@objc(CordovaPluginRichNotifications) class CordovaPluginRichNotifications : CDVPlugin, UNUserNotificationCenterDelegate {
  @objc(sendNotification:)
  func sendNotification(command: CDVInvokedUrlCommand) {
    print("Hello Swift sendNotification")

    let eventDateAsString = command.arguments[0] as? String ?? ""
    print("Date as string: ", eventDateAsString)

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let date = formatter.date(from: eventDateAsString)

    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
                                                                                        if !accepted {
                                                                                          print("Notification access denied.")
                                                                                        }
                                                                                       }

    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents(in: .current, from: date!)
    let scheduledMinutes = components.minute! + 1
    let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: scheduledMinutes)
    let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)

    print("scheduledMinutes: " + String(describing: scheduledMinutes))
    print("components.minute: " + String(describing: components.minute))
    print("newComponents: " + newComponents.description)

    let content = UNMutableNotificationContent()
    content.title = "My Anatol"
    content.body = "Example of rich push notifications!"
    //content.sound = UNNotificationSound.default()

    if let path = Bundle.main.path(forResource: "logo", ofType: "png") {
      let url = URL(fileURLWithPath: path)

      do {
        let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
        content.attachments = [attachment]
      } catch {
        print("The attachment was not loaded.")
      }
    }

    let ac1 = setAction(id: "reply", title: "Reply")
    let ac4 = setAction(id: "destructive", title: "Cancel")
    let ac5 = setAction(id: "direction", title: "Get Direction")

    let category = UNNotificationCategory(identifier: "customContent", actions: [ac5, ac1, ac4], intentIdentifiers: [], options: .allowInCarPlay)
    UNUserNotificationCenter.current().setNotificationCategories([category])
    content.categoryIdentifier = "customContent"


    let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)

    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(request) {(error) in
                                                     if let error = error {
                                                       print("Uh oh! We had an error: \(error)")
                                                     }
                                                    }

    //======
    UNUserNotificationCenter.current().delegate = self
    //======

    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: "passed "
    )

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

    print("response.actionIdentifier" + response.actionIdentifier)
  }

  private func setAction(id: String, title: String, options: UNNotificationActionOptions = []) -> UNNotificationAction {

    let action = UNNotificationAction(identifier: id, title: title, options: options)

    return action
  }
}