import 'package:dartz/dartz.dart';
import 'package:yoo_live/Core/Error/Failure.dart';
import 'package:yoo_live/Features/data/Entity/UserEntity.dart';
import 'package:yoo_live/Features/domain/DataSource/AuthDataSource.dart';

abstract class AuthDataRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithFaceBook();
}

class AuthDataRepositoryImpl extends AuthDataRepository {
  final AuthDataSource authDataSource;

  AuthDataRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final userModel = await authDataSource.signInWithGoogle();
      return right(userModel);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFaceBook() async {
    try {
      final userModel = await authDataSource.signInWithFacebook();
      return right(userModel);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
