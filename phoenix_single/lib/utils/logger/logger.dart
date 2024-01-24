import 'package:ansicolor/ansicolor.dart';

enum LoggerType { info, warning, error, player }

class Logger {
  final String text;
  final LoggerType type;

  Logger({required this.text, required this.type});

  final AnsiPen _pen = AnsiPen();

  void log() {
    late String prefix;

    switch (type) {
      case LoggerType.info:
        _pen
          ..white()
          ..xterm(10, bg: false);

        prefix = '[INFO]';
        break;
      case LoggerType.warning:
        _pen
          ..white()
          ..xterm(3, bg: false);

        prefix = '[WARNING]';
        break;
      case LoggerType.error:
        _pen
          ..white()
          ..xterm(9, bg: false);

        prefix = '[ERROR]';
        break;
      case LoggerType.player:
        _pen
          ..white()
          ..xterm(14, bg: false);

        prefix = '[PLAYER]';
        break;
    }

    print('${_pen(prefix)} ${_pen(text)}');
  }
}
