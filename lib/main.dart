import 'package:clean_architecture_cubit/domain/entities/results.dart';
import 'package:clean_architecture_cubit/presentation/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ResultsAdapter());
  if (await InternetConnectionChecker().hasConnection) {
   await Hive.openBox<Results>('top_rated_movies');
    final box = Hive.box<Results>('top_rated_movies');
    box.clear();
  }
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Clean Architecture Cubit',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
