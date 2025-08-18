import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoo_live/Constants/ApiConstants.dart';
import 'package:yoo_live/Core/Error/Failure.dart';
import 'package:yoo_live/Core/network/ApiResult.dart';
import 'package:yoo_live/Core/network/DioClient.dart';
import 'package:yoo_live/Features/domain/Model/AuthProfile.dart';
import 'package:yoo_live/Features/domain/Model/AuthUserModelReponse.dart';
import 'package:yoo_live/Features/domain/Model/FacebookSignInReponseModel.dart';
import 'package:yoo_live/Features/domain/Model/SignInTokenReponseModel.dart';
import 'package:yoo_live/Features/domain/Model/TokenResponse.dart';
import 'package:yoo_live/Features/domain/Model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yoo_live/Features/domain/Service/UserGeolocationService.dart';

abstract class AuthDataSource {
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<ApiResult<TokenResponse>> fetchNewAccessTokenWithRefreshToken();
  Future<ApiResult<AuthProfile>> fetchProfileDetails();
}

class AuthDataSourceImpl extends AuthDataSource {
  final GoogleSignIn _googleSignIn;
  final FacebookAuth facebookAuth;
  final DioClient _dioClient;
  final SharedPreferences sharedPreferences;

  AuthDataSourceImpl({
    GoogleSignIn? googleSignIn,
    FacebookAuth? facebookAuth,
    required DioClient dioClient,
    required this.sharedPreferences,
  }) : _googleSignIn = googleSignIn ?? GoogleSignIn(),
       facebookAuth = facebookAuth ?? FacebookAuth.instance,
       _dioClient = dioClient;

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw ServerFailure(message: "Google sign in failed");
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleSignInTokenResponseModel signInTokenResponseModel =
          await googleExtractToken(googleAuth.accessToken ?? "");

      final geoLocationData =
          await UserGeolocationService().getCountryCodeFromIp();

      final UserModel userModel = UserModel(
        uid: signInTokenResponseModel.sub ?? "",
        name: signInTokenResponseModel.name ?? "",
        email: signInTokenResponseModel.email ?? "",
        country: geoLocationData?.countryCode ?? "",
        imgUrl: signInTokenResponseModel.picture ?? "",
      );

      //save user data to Db
      final authModelResponse = await saveDataToDb(userModel);

      authModelResponse.when(
        (data, success) => {
          //save the tokens to sharedPreference
          sharedPreferences.setString(
            ApiConstants.accessTokenKey,
            data.data?.accessToken ?? "",
          ),
          sharedPreferences.setString(
            ApiConstants.refreshTokenKey,
            data.data?.refreshToken ?? "",
          ),
        },
        (failure, statusCode) => {print(failure)},
      );
      return userModel;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      final LoginResult result = await facebookAuth.login();

      final response = await facebookExtractToken(
        result.accessToken?.tokenString ?? "",
      );
      final geoLocationData =
          await UserGeolocationService().getCountryCodeFromIp();

      UserModel userModel = UserModel(
        uid: response.id ?? "",
        name: response.name ?? "",
        email: response.email ?? "",
        country: geoLocationData?.countryCode ?? "",
        imgUrl: response.picture?.data?.url ?? "",
      );

      final authModelResponse = await saveDataToDb(userModel);

      authModelResponse.when(
        (data, success) => {
          //save the tokens to sharedPreference
          sharedPreferences.setString(
            ApiConstants.accessTokenKey,
            data.data?.accessToken ?? "",
          ),
          sharedPreferences.setString(
            ApiConstants.refreshTokenKey,
            data.data?.refreshToken ?? "",
          ),
        },
        (failure, statusCode) => {print(failure)},
      );

      return userModel;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  Future<ApiResult<AuthUserModelResponse>> saveDataToDb(UserModel userModel) {
    return _dioClient.apiResponseHandler(
      'api/v1/auth',
      method: 'POST',
      data: jsonEncode(userModel.toJson()),
      options: Options(headers: {"Content-Type": "application/json"}),
      parser: (json) => AuthUserModelResponse.fromJson(json),
    );
  }

  Future<GoogleSignInTokenResponseModel> googleExtractToken(
    String accessToken,
  ) async {
    const String url = "https://www.googleapis.com/oauth2/v3/userinfo";
    try {
      final dio = Dio();
      final response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        final String? sub = data['sub'] as String?;
        final String? name = data['name'] as String?;
        final String? givenName = data['given_name'] as String?;
        final String? familyName = data['family_name'] as String?;
        final String? email = data['email'] as String?;
        final String? picture = data['picture'] as String?;
        final bool? emailVerified = data['email_verified'] as bool?;

        return GoogleSignInTokenResponseModel(
          sub: sub,
          name: name,
          givenName: givenName,
          familyName: familyName,
          picture: picture,
          email: email,
          emailVerified: emailVerified,
        );
      } else {
        throw Exception('Failed to fetch user data');
      }
    } on Exception catch (e) {
      return throw ServerFailure(message: 'Failed to fetch user data: $e');
    }
  }

  Future<FacebookSignInResponseModel> facebookExtractToken(
    String accessToken,
  ) async {
    final String url = "https://graph.facebook.com/me";
    try {
      final dio = Dio();
      final response = await dio.get(
        url,
        queryParameters: {
          'access_token': accessToken,
          'fields': 'id,name,email,picture',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);
        return FacebookSignInResponseModel.fromJson(data);
      } else {
        return throw ServerFailure(
          message: "failed to fetch user data from facebook",
        );
      }
    } catch (e) {
      return throw ServerFailure(
        message: "failed to fetch user data from facebook $e",
      );
    }
  }

  @override
  Future<ApiResult<TokenResponse>> fetchNewAccessTokenWithRefreshToken() async {
    final refreshToken = sharedPreferences.getString(ApiConstants.refreshTokenKey);

    return _dioClient.apiResponseHandler(
      '/api/v1/auth/refresh-token',
      method: 'PATCH',
      data: {
        "refreshToken": refreshToken
      },
      parser: (json) {
        print(json);
        return TokenResponse.fromJson(json);},
    );
  }

  @override
  Future<ApiResult<AuthProfile>> fetchProfileDetails() {
    return _dioClient.apiResponseHandler(
      '/api/v1/profile',
      method: 'GET',
      parser: (json) => AuthProfile.fromJson(json),
    );
  }
}
