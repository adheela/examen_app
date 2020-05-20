import 'package:examen_app/screens/quiz_screen.dart';
import 'package:examen_app/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:examen_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:examen_app/components/network.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:examen_app/screens/welcome_screen.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/register.jpg"), fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo_quiz.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Text("☻ Password should be minimum 6 character's and maximum 8 character's And Also make sure 'Gmail' Sign In Only"),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    onPress: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      //print(email);
                      try {
                        final newUser =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);

                        if (newUser != null) {
                          Networkhelper networkhelper = Networkhelper("http://www.mocky.io/v2/5ebd2f5f31000018005b117f");
                          var quiz = await networkhelper.getData();
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return QuizScreen(quizes: quiz,);
                          }));
                          //Navigator.pushNamed(context, QuizScreen.id);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        Alert(
                            context: context,
                            title: "Invalid!",
                            desc: "Invalid password or userId.",
                            image: Image.asset('images/Incorrect.jpg'),
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "ReEnter",
                                  style: TextStyle(
                                    color: Colors.white, fontSize: 20,
                                  ),
                                ),
                                onPressed: () => Navigator.pushNamed(context, WelcomeScreen.id),
                                color: Color(0xFFF0707F),
                              )
                            ]
                        ).show();
                        print(e);
                      }
                    },
                    label: 'Register',
                    colour: Color(0xFFF0707F))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
