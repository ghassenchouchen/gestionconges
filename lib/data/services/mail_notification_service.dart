import 'dart:convert';
import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:pfeconges/data/configs/api.dart';
import 'package:pfeconges/data/core/extensions/date_time.dart';
import 'package:pfeconges/data/model/employee/employee.dart';
import 'package:pfeconges/data/model/leave/leave.dart';

@LazySingleton()
class NotificationService {
  final FirebaseCrashlytics _crashlytics;
  final http.Client _httpClient;

  NotificationService(this._httpClient, this._crashlytics);

  @disposeMethod
  Future<void> dispose() async {
    _httpClient.close();
  }

  Future<void> notifyManagerForNewLeave(
      {required String name,
      required String reason,
      required DateTime startDate,
      required String duration,
      required DateTime endDate,
      required String receiver}) async {
    if (kDebugMode) return;
    try {
      http.Response response =
          await _httpClient.post(Uri.https(baseURL, 'api/leave/new'),
              body: json.encode({
                'name': name,
                "date": getFormatDate(startDate: startDate, endDate: endDate),
                "status": LeaveStatus.pending.value,
                'reason': reason,
                'duration': duration,
                'receiver': receiver,
              }));
      if (response.statusCode == 200) {
        log('New Leave notification mail send successfully',
            name: 'Notification');
      }
    } on Exception catch (e) {
      await _crashlytics.log(e.toString());
    }
  }

  Future<void> leaveResponse(
      {required String name,
      required DateTime startDate,
      required DateTime endDate,
      required LeaveStatus status,
      required String receiver}) async {
    try {
      http.Response response =
          await _httpClient.post(Uri.https(baseURL, 'api/leave/update'),
              body: json.encode({
                "name": name,
                "date": getFormatDate(startDate: startDate, endDate: endDate),
                "status": status.value,
                "receiver": receiver,
              }));
      if (response.statusCode == 200) {
        log('Demande de congé mise à jour',
            name: 'Notification');
      }
    } on Exception catch (e) {
      await _crashlytics.log(e.toString());
    }
  }

  String getFormatDate({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (startDate.dateOnly.isAtSameMomentAs(endDate.dateOnly)) {
      return DateFormat('dd MMM yyyy').format(startDate);
    }
    return '${DateFormat('dd MMM yyyy').format(startDate)} to ${DateFormat('dd MMM yyyy').format(endDate)}';
  }

sendEmail(BuildContext context //For showing snackbar
    ) async {
  String username = 'abc@gmail.com'; //Your Email
  String password =
      'nhxw ipap yrtn ffot'; 

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
        ..from = Address(username, 'Administrateur')
        ..recipients.add('recipient-email@gmail.com')
        // ..ccRecipients.addAll(['abc@gmail.com', 'xyz@gmail.com']) // For Adding Multiple Recipients
        // ..bccRecipients.add(Address('a@gmail.com')) For Binding Carbon Copy of Sent Email
        ..subject = 'Invitation à lapplication mobile'
        ..text = 'Invitation à lapplication mobile,Votre login et mot de passe'
      // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>"; // For Adding Html in email
      // ..attachments = [
      //   FileAttachment(File('image.png'))  //For Adding Attachments
      //     ..location = Location.inline
      //     ..cid = '<myimg@3.141>'
      // ]
      ;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Mail Send Successfully")));
  } on MailerException catch (e) {
    print('Message not sent.');
    print(e.message);
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
} 

  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.
  Future<void> sendInviteNotification(
      {required String departmentName, required String receiver, required Role role,}) async {
    try {
      http.Response response =
          await _httpClient.post(Uri.https(baseURL, '/api/invitation'),
              body: json.encode({
                "receiver": receiver,
                "companyname": departmentName,
                "spacelink": "",
                "role":role,
              }));
      if (response.statusCode == 200) {
        log('Invite notification mail send successfully', name: 'Notification');
      }
    } on Exception catch (e) {
      await _crashlytics.log(e.toString());
    }
  }

  Future<void> sendSpaceInviteAcceptNotification(
      {required String sender, required String receiver}) async {
    try {
      http.Response response =
          await _httpClient.post(Uri.https(baseURL, '/api/acceptence'),
              body: json.encode({
                "receiver": receiver,
                "sender": sender,
              }));
      if (response.statusCode == 200) {
        log('Accept invitation notification mail send successfully',
            name: 'Notification');
      }
    } on Exception catch (e) {
      await _crashlytics.log(e.toString());
    }
  }
}
