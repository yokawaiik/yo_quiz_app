import 'package:flutter/material.dart';

// md - 500
const _primary = Color(0xff9575cd);
const _primaryDark = Color(0xff65499c);
const _primaryLight = Color(0xffc7a4ff);

const _onPrimary = Colors.white;

const _secondary = Color(0xff4db6ac);
const _secondaryDark = Color(0xff00867d);
const _secondaryLight = Color(0xff82e9de);

class MessengerTheme {

  final themeLight = ThemeData(
    colorScheme: ColorScheme(
      primary: _primary,
      primaryVariant: _primaryDark,
      secondary: _secondary,
      secondaryVariant: _secondaryDark,
      surface: Color(0xffffffff),
      background: Color(0xffc7d7c1),
      error: Color(0xffd32f2f),
      onPrimary: _onPrimary,
      onSecondary: Color(0xffffffff),
      onSurface: Color(0xff000000),
      onBackground: Color(0xff000000),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(
          color: _primaryDark,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(
          color: _primary,
          width: 2.0,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline4: TextStyle(color: _primary, fontWeight: FontWeight.w600),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(_onPrimary,)
      )
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return _primary; // the color when checkbox is selected;
          }
          return _primaryDark; //the color when checkbox is unselected;
        },
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _primary,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
    )
  );


}

final messengerTheme = MessengerTheme();