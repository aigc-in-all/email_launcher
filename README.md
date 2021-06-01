# email_launcher

Flutter plugin for launching emails on mobile platforms. Support iOS and Android.

## Usage
To use this plugin, add `email_launcher` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

### Example

```dart
Email email = Email(
    to: ['one@gmail.com,two@gmail.com'],
    cc: ['foo@gmail.com'],
    bcc: ['bar@gmail.com'],
    subject: 'subject',
    body: 'body'
);
await EmailLauncher.launch(email);
```

#### Complete example

``` dart
import 'dart:async';

import 'package:flutter/services.dart';

class EmailLauncher {
  static const MethodChannel _channel = const MethodChannel('email_launcher');

  static Future<void> launch(Email email) {
    return _channel.invokeMethod('launch', email.toJson());
  }
}

class Email {
  final List<String> to;
  final List<String> cc;
  final List<String> bcc;
  final String subject;
  final String body;

  Email(
      {this.to = const [],
      this.cc = const [],
      this.bcc = const [],
      this.subject = '',
      this.body = ''});

  Map<String, dynamic> toJson() {
    return {'to': to, 'cc': cc, 'bcc': bcc, 'subject': subject, 'body': body};
  }
}
```