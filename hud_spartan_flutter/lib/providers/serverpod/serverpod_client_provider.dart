import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hud_spartan_client/hud_spartan_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

final serverpodClientProvider = Provider<Client>((ref) {
  final client = Client('http://localhost:8080/')
    ..connectivityMonitor = FlutterConnectivityMonitor();
  return client;
});
