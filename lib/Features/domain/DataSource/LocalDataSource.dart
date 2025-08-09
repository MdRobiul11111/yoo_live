import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoo_live/Core/Error/Failure.dart';

import '../../../Constants/ApiConstants.dart';

abstract class LocalDataSource{
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearUserData();
  Future<bool> isUserSignedIn();
}


class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences sharedPreferences;


  LocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> clearUserData() async{
    try {
      await Future.wait([
        sharedPreferences.remove(ApiConstants.accessTokenKey),
        sharedPreferences.remove(ApiConstants.refreshTokenKey),
        sharedPreferences.remove(ApiConstants.userDataKey),
      ]);
    } catch (e) {
      throw CacheFailure( message:'Failed to clear user data');
    }
  }

  @override
  Future<String?> getAccessToken() async{
    try{
      return sharedPreferences.getString(ApiConstants.accessTokenKey);
    }catch(e){
      return throw CacheFailure(message:"Failed to get access token");
    }
  }

  @override
  Future<String?> getRefreshToken() async{
    try{
      return sharedPreferences.getString(ApiConstants.refreshTokenKey);
    }catch(e){
      return throw CacheFailure(message:"Failed to get refresh token");
    }
  }

  @override
  Future<bool> isUserSignedIn() async{
    try {
      final refreshToken = await getRefreshToken();
      return refreshToken != null;
    } catch (e) {
      return false;
    }
  }

}