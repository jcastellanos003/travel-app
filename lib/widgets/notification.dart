//https://medium.com/flutter-community/flutter-notifications-bubble-up-and-values-go-down-c1a499d22d5f

import 'package:flutter/material.dart';

class NotificationGeneric extends Notification {
  final String message;

  const NotificationGeneric({this.message});
}
