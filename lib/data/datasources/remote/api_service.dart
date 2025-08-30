import 'package:dio/dio.dart';
import 'package:grocery_go/data/models/requests/login_schema.dart';
import 'package:grocery_go/data/models/responses/login_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
@lazySingleton
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;

  @POST('/auth/login')
  Future<LoginDto> login(@Body() LoginSchema loginSchema);
}
