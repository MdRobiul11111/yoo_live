import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:yoo_live/Features/Bloc/AuthBloc/auth_bloc.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/DataSource/AuthDataSource.dart';
import 'package:yoo_live/widget/presentation/splash_widget/splash_screen.dart';

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

void initDependency(){
  sl.registerLazySingleton<AuthDataSource>(()=>AuthDataSourceImpl());
  sl.registerLazySingleton<AuthDataRepository>(()=>AuthDataRepositoryImpl(sl()));
  sl.registerLazySingleton(()=>AuthBloc(sl()));
}
