enum ClientPackets {
  login,
  register,
}

extension ClientPacketsExtension on ClientPackets {
  static int get count => ClientPackets.values.length;
}
