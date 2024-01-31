import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'assets/adapter/hive_type_adapter.dart';
import 'core/hive/stoage_repository.dart';
import 'features/presentation/profile_screen.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerAdapters();
  /* await StorageRepository.getInstance(); */
  await HiveService().initHive();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProfileScreen(),
        );
      },
    );
  }
}
