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
import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _toController = TextEditingController();
  final _ccController = TextEditingController();
  final _bccController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _toController.dispose();
    _ccController.dispose();
    _bccController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _launchEmail() async {
    List<String> to = _toController.text.split(',');
    List<String> cc = _ccController.text.split(',');
    List<String> bcc = _bccController.text.split(',');
    String subject = _subjectController.text;
    String body = _bodyController.text;

    Email email = Email(to: to, cc: cc, bcc: bcc, subject: subject, body: body);
    await EmailLauncher.launch(email);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: _toController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54)),
                      hintText: 'Enter to'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: _ccController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54)),
                      hintText: 'Enter cc'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: _bccController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54)),
                      hintText: 'Enter bcc'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54)),
                      hintText: 'Enter subject'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: _bodyController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54)),
                      hintText: 'Enter body'),
                ),
              ),
              RaisedButton(onPressed: _launchEmail, child: Text('Launch Email'))
            ],
          ),
        ),
      ),
    );
  }
}
```