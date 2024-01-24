enum ClientPackets {
  login,
  signUp,
}

extension ClientPacketsExtension on ClientPackets {
  static int get count => ClientPackets.values.length;
}
