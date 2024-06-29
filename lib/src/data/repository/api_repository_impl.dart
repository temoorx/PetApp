import 'package:logger/logger.dart';
import 'package:your_app_test/src/data/common/object_mapper.dart';
import 'package:your_app_test/src/data/datasource/api/api_service.dart';
import 'package:your_app_test/src/domain/repository/api_repository.dart';


class ApiRepositoryImpl extends ApiRepository {
  final ApiService youAppApi;
  final ObjectMapper objectMapper;
  final Logger logger;

  ApiRepositoryImpl({
    required this.youAppApi,
    required this.objectMapper,
    required this.logger,
  });

  
}
