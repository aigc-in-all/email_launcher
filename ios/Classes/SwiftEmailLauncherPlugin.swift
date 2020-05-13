import Flutter
import UIKit
import MessageUI

public class SwiftEmailLauncherPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "email_launcher", binaryMessenger: registrar.messenger())
        let instance = SwiftEmailLauncherPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "launch":
            launchEmail(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    private func launchEmail(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let email = parseArgs(call, result: result) else {return}
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            result(FlutterError.init(code: "error", message: "Unable to get view controller", details: nil))
            return
        }
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients(email.to)
            mailComposeVC.setCcRecipients(email.cc)
            mailComposeVC.setBccRecipients(email.bcc)
            if let subject = email.subject {
                mailComposeVC.setSubject(subject)
            }
            if let body = email.body {
                mailComposeVC.setMessageBody(body, isHTML: false)
            }
            viewController.present(mailComposeVC, animated: true, completion: {result(nil)})
            
        } else {
            result(FlutterError.init(code: "-1", message: "No email clients found!", details: nil))
        }
    }
    
    private func parseArgs(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Email? {
        guard let args = call.arguments as? [String: Any?] else {
            result(FlutterError.init(code: "error", message: "args are not map", details: nil))
            return nil
        }
        return Email(
            to: args[Email.TO] as? [String],
            cc: args[Email.CC] as? [String],
            bcc: args[Email.BCC] as? [String],
            subject: args[Email.SUBJECT] as? String,
            body: args[Email.BODY] as? String)
    }
}

extension SwiftEmailLauncherPlugin: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

struct Email {
    static let TO = "to"
    static let CC = "cc"
    static let BCC = "bcc"
    static let SUBJECT = "subject"
    static let BODY = "body"
    
    let to: [String]?
    let cc: [String]?
    let bcc:[String]?
    let subject: String?
    let body: String?
}
