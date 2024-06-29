// ignore: depend_on_referenced_packages

// ignore: depend_on_referenced_packages


import 'package:dio/dio.dart';
import 'package:your_app_test/src/data/dto/base_response_dto.dart';

///
///
class ApiService {
  static const String test = 'test';

  final Dio dio;

  const ApiService(this.dio);


  Future<BaseResponseDto> bookAppointment(
      {required String appointmenDate,
      required String method,
      required String paymentType,
      required String requestType,
      required String serviceName,
      required String timeSlot,
      required String technologyType,
      required bool initialPayment,
      required int price}) async {
    final response = await dio.post(test, data: {
      'appointmentDate': appointmenDate,
      'method': method,
      'paymentType': paymentType,
      'request': requestType,
      'serviceName': serviceName,
      'timeSlot': timeSlot,
      'type': technologyType,
      'price': price,
      'initialPayment': initialPayment
    });
    return BaseResponseDto.fromJson({"data": response.data}, (value) => value);
  }
}
