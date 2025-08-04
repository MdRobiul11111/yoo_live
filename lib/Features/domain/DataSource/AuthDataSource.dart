import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:yoo_live/Core/Error/Failure.dart';
import 'package:yoo_live/Features/domain/Model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDataSource {
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
}

class AuthDataSourceImpl extends AuthDataSource {
  final fb_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth facebookAuth;

  AuthDataSourceImpl({
    fb_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FacebookAuth? facebookAuth,
  })  : _firebaseAuth = firebaseAuth ?? fb_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        facebookAuth = facebookAuth ?? FacebookAuth.instance;

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if(googleUser==null){
        throw ServerFailure(message: "Google sign in failed");
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final fb_auth.AuthCredential credential = fb_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final fb_auth.UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      if(userCredential != null){
        return UserModel.fromFirebaseUser(userCredential.user!);
      }else{
        throw ServerFailure(message: "Firebase user not found after Google Sign-In");
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async{
      try{
        final LoginResult result = await facebookAuth.login();
        final fb_auth.OAuthCredential facebookAuthCredential = fb_auth.FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final fb_auth.UserCredential userCredential = await _firebaseAuth.signInWithCredential(facebookAuthCredential);
        if(userCredential != null){
          return UserModel.fromFirebaseUser(userCredential.user!);
        }else{
          throw ServerFailure(message: "Firebase user not found after Google Sign-In");
        }
      }catch(e){
        throw ServerFailure(message: e.toString());
      }
  }
}
