import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoo_live/Core/Error/Failure.dart';

import '../../../Constants/ApiConstants.dart';

abstract class LocalDataSource{
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<bool> isUserSignedIn();
  Future<void> setNewAccessToken(String newAccessToken);
  Future<DateTime?> getIssuedAt();
}


class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl(this.sharedPreferences);

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

  @override
  Future<void> setNewAccessToken(String newAccessToken) async{
    try{
      await sharedPreferences.setString(ApiConstants.accessTokenKey, newAccessToken);
      await sharedPreferences.setInt(
        ApiConstants.issuedAtKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    }catch(e){
      throw CacheFailure(message:"Failed to set new access token");
    }
  }

  @override
  Future<DateTime?> getIssuedAt() async{
    try{
      final millis = sharedPreferences.getInt(ApiConstants.issuedAtKey);
      if(millis != null){
        return DateTime.fromMillisecondsSinceEpoch(millis);
      }else{
        return null;
      }

    }catch(e){
      return throw CacheFailure(message:"Failed to get validity");
    }
  }

}