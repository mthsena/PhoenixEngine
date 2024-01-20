enum ServerPackets {
  alertMsg,
}

extension ServerPacketsExtension on ServerPackets {
  static int get count => ServerPackets.values.length;
}
