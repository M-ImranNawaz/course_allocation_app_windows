import 'dart:convert';

import 'package:course_allocation/database/programs_adapter.dart';
import 'package:course_allocation/main.dart';
import 'package:course_allocation/services/base_client.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class HomePageController extends GetxController {
  TextEditingController progC = TextEditingController();
  TextEditingController cProgramC = TextEditingController();
  TextEditingController cDepartmentC = TextEditingController();
  TextEditingController cContactHoursC = TextEditingController();
  TextEditingController cCreditHoursC = TextEditingController();
  TextEditingController cCodeC = TextEditingController();
  TextEditingController cNameC = TextEditingController();
  addProgram() {
    prosBox.add(Program(name: progC.text));
  }

  sendEmail() async {
    String name = 'imran';
    String email = 'imrannawaz288@gmail.com';
    String subject = 'imran hi';
    String message = 'imran khan';

    BaseClient client = BaseClient();
    var serviceId = 'service_s9zncpn';
    var templateId = 'template_tlrrkfd';
    var userId = 'iD1PzE5rwvyHgB3Os';
    var response = await client.post(
        'https://api.emailjs.com/api/v1.0/email/send', '', {
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'user_name': name,
        'user_email': email,
        'user_subject': subject,
        'user_message': message
      }
    },);
    print(response.toString());
  }

  sendMail() async {
    String username = 'khalidali03015018137';
    String password = '03015018137';
    var reciever = 'imrannawaz288@gmail.com';
    final smtpServer = gmail(username, password);
    final equivalentMessage = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add(Address(reciever))
      // ..ccRecipients
      //     .addAll([Address(reciever), reciever])
      // ..bccRecipients.add(reciever)
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    await send(equivalentMessage, smtpServer);
  }
}
