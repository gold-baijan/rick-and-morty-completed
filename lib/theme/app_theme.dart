import 'package:flutter/material.dart';
import 'package:rick_and_morty2/constants/app_colors.dart';

class AppThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appBarColorDark,
      iconTheme: IconThemeData(color: AppColors.vectorColorDark),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.nBNColorDark,
      selectedItemColor: AppColors.bNBSelectedIColorDark,
      unselectedItemColor: AppColors.bNBUnselectedIColorDark,
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appBarColorLight,
      iconTheme: IconThemeData(color: AppColors.vectorColorLight),
      titleTextStyle: TextStyle(color: Colors.black),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.nBNColorLight,
      selectedItemColor: AppColors.bNBSelectedIColorLight,
      unselectedItemColor: AppColors.bNBUnselectedIColorLight,
    ),
  );
}
