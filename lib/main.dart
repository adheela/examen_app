import 'package:flutter/material.dart';
import 'package:examen_app/screens/welcome_screen.dart';
import 'package:examen_app/screens/login_screen.dart';
import 'package:examen_app/screens/registration_screen.dart';
import 'package:examen_app/screens/quiz_screen.dart';

void main() => runApp(Examen());

class Examen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        QuizScreen.id: (context) => QuizScreen(),
      },
    );
  }
}
