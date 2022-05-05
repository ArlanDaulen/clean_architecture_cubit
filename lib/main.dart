import 'package:clean_architecture_cubit/domain/entities/results.dart';
import 'package:clean_architecture_cubit/presentation/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ResultsAdapter());
  // Hive.openBox<Results>('top_rated_movies');
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
