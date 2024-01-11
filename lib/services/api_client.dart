import 'package:project_login/models/Users.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:shared_preferences/shared_preferences.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "http://testapidragon-001-site1.anytempurl.com/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  static Dio _createDio() {
    final dio = Dio();
    return dio;
  }

  static Future<String> getSavedTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  static Future<RestClient> createRestClient() async {
    final dio = _createDio();
    final token = await getSavedTokenFromSharedPreferences();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
    return RestClient(dio);
  }

  @POST("/tai-khoan/dang-nhap")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
  })
  Future<Users?> login(@Body() Map<String, dynamic> map);

  @POST("/tai-khoan/dang-ky")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
  })
  Future<Users?> register(@Body() Map<String, dynamic> map);

  @POST("/tai-khoan/quen-mat-khau")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
  })
  Future<Users?> forgotPassword(@Body() Map<String, dynamic> map);

  @POST("/tai-khoan/verify/{code}")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
  })
  Future<Users?> verify(@Path("code") int code);

  @POST("/tai-khoan/change-password/{idUser}")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
  })
  Future<Users?> changePassword(@Body() Map<String, dynamic> map,@Path("idUser") String idUser);

  @GET("/tai-khoan/get-data")
  Future<String> getData(@Header("Authorization") String auth);
}