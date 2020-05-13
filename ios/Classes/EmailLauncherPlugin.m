#import "EmailLauncherPlugin.h"
#if __has_include(<email_launcher/email_launcher-Swift.h>)
#import <email_launcher/email_launcher-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "email_launcher-Swift.h"
#endif

@implementation EmailLauncherPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEmailLauncherPlugin registerWithRegistrar:registrar];
}
@end
