import 'package:phoenix_single/phoenix_single.dart';

void main() {
  /// Cria uma nova instância da classe ServerSetup
  ServerSetup serverSetup = ServerSetup(address: '127.0.0.1', port: 7001);

  /// Inicia o servidor chamando o método startServer na instância serverSetup
  serverSetup.startServer();
}
