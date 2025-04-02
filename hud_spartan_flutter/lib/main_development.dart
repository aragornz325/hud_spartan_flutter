import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hud/app/app.dart';
import 'package:hud/bootstrap.dart';

void main() {
  bootstrap(
    () => const ProviderScope(
      child: App(),
    ),
  );
}
