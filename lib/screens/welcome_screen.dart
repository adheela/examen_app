import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:examen_app/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation animate;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    animate = CurvedAnimation(parent: controller, curve: Curves.bounceIn);

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {
        controller.value;
        //print(controller.value);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/welcome.jpg"), fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo_quiz.png'),
                      height: animate.value *100,
                    ),
                  ),
                  ColorizeAnimatedTextKit(
                      text: [
                        "Examen",
                      ],
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 50.0,
                        fontFamily: "Horizon",
                        color: Colors.white,
                      ),
                      colors: [
                        Colors.lightGreenAccent,
                        Colors.yellowAccent,
                        Colors.white,
                      ],
                      alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                  ),
                ],
              ),
              SizedBox(
                width: 48.0,
              ),
              RoundedButton(
                onPress: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                label: 'Log In',
                colour: Color(0xFFF0707F),),
              RoundedButton(
                  onPress: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  label: 'New User Register',
                  colour: Color(0xFFF18786),
              ),
              SizedBox(
                width: 48.0,
              ),
              Text("New to the Quiz Please Register in the New User Register ☻",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}