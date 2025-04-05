import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hud/providers/dio/dio_provider.dart';
import 'package:hud/repositories/email/send_email.dart';


final emailServiceProvider = Provider<EmailService>((ref) {
  final dio = ref.read(dioProvider);
  return EmailService(dio);
});