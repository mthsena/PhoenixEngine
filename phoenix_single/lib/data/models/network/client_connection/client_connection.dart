import 'dart:io';

interface class ClientConnectionModel {
  final int id;
  final Socket socket;

  ClientConnectionModel({required this.id, required this.socket});
}
