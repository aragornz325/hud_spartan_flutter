
import 'package:dio/dio.dart';

class EmailService {

  EmailService(this.dio);
  
  final Dio dio;

  Future<dynamic> sendEmail(
    String? phone,
    String? location, {
    required String email,
    required String message,
  }) async {
    final body = {
      'phone': phone ?? 'no phone',
      'location': location ?? 'no location',
      'email': email,
      'message': message,
    };

    try {
      final response = await dio.post(
        '/sendEmail',
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data ?? {'error': e.message};
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
