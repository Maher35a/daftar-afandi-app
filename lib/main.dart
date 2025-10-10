import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Cubits/ storeCubit/store_cubit.dart';
import 'Cubits/person__cubit.dart';
import 'features/Hive/hive_service.dart';
import 'features/home/home_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await HiveService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PersonCubit()..loadPeople(),
        ),
        BlocProvider(
          create: (_) => StoreCubit(HiveService.getStoreBox())..loadProducts(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(420, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'دفتر أفندي',
            theme: ThemeData(primarySwatch: Colors.indigo),
            home: child,
          );
        },
        child: const HomePage(),
      ),
    );
  }
}
