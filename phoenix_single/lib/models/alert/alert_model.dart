import 'package:phoenix_single/models/alert/alert_type.dart';

interface class AlertModel {
  final String title;
  final String message;
  final AlertType type;

  AlertModel({required this.title, required this.message, required this.type});
}
