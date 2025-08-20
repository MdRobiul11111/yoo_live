import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoo_live/Core/network/AuthInterceptor.dart';
import 'package:yoo_live/Features/Bloc/AuthBloc/auth_bloc.dart';
import 'package:yoo_live/Features/Bloc/AuthProfileBloc/auth_profile_bloc.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/DataSource/AuthDataSource.dart';
import 'package:yoo_live/Features/domain/DataSource/LocalDataSource.dart';
import 'package:yoo_live/widget/presentation/splash_widget/splash_screen.dart';
import 'Core/network/DioClient.dart';
import 'Features/Bloc/SearchProfileBloc/search_profile_bloc.dart';

final sl = GetIt.instance;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  initDependency();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {      
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<AuthProfileBloc>()),
        BlocProvider(create: (context) => sl<SearchProfileBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

void initDependency() async{
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(()=>DioClient(sl()));
  sl.registerLazySingleton<AuthDataSource>(()=>AuthDataSourceImpl(dioClient: sl(),sharedPreferences: sl()));
  sl.registerLazySingleton<LocalDataSource>(()=>LocalDataSourceImpl(sl()));
  sl<Dio>().interceptors.add(AuthInterceptor(sl(),sl(),sl()));
  sl.registerLazySingleton<AuthDataRepository>(()=>AuthDataRepositoryImpl(sl()));
  sl.registerLazySingleton(()=>AuthBloc(sl(),sl()));
  sl.registerLazySingleton(()=>AuthProfileBloc(sl()));
  sl.registerLazySingleton(()=>SearchProfileBloc(sl()));
}
