enum ServerPackets {
  alertMsg,
  sendId,
  sendHighId,
}

extension ServerPacketsExtension on ServerPackets {
  static int get count => ServerPackets.values.length;
}
