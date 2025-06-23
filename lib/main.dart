import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty2/model/fav_character.dart';
import 'package:rick_and_morty2/screens/splash_screen.dart';
import 'package:rick_and_morty2/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(FavCharacterAdapter());
  await Hive.openBox<FavCharacter>('favorites');

  //  await Hive.deleteBoxFromDisk('favorites'); // удалить старый box
  // await Hive.openBox<FavCharacter>('favorites'); // открыть снова с правильным типом


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}