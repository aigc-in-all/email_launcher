import 'dart:async';

import 'package:flutter/services.dart';

class EmailLauncher {
  static const MethodChannel _channel = const MethodChannel('email_launcher');

  static Future<bool> launch(Email email) async {
    final bool result = await _channel.invokeMethod('launch', email.toJson());
    return result;
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
