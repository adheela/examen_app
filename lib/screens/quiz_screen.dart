import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:examen_app/components/choice_button.dart';
import 'package:examen_app/components/rounded_button.dart';
import 'package:examen_app/screens/welcome_screen.dart';


FirebaseUser loggedInUser;



class QuizScreen extends StatefulWidget {

  QuizScreen({this.quizes});

  static const String id = 'quiz_screen';
  final quizes;
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  var score = 0;
  var qno = 0;
  final _auth = FirebaseAuth.instance;

  var images = ["engine", "year", "saveLayer", "qu4", "lang"];
  String que, ch1, ch2, ch3, ch4;
  int length;



  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void updateUI(dynamic decodedData) {
    length = decodedData['Quiz Questions'].length;
    que = decodedData['Quiz Questions'][qno]['Questions'];
    ch1 = decodedData['Quiz Questions'][qno]['Answers'][0]['Answers'];
    ch2 = decodedData['Quiz Questions'][qno]['Answers'][1]['Answers'];
    ch3 = decodedData['Quiz Questions'][qno]['Answers'][2]['Answers'];
    ch4 = decodedData['Quiz Questions'][qno]['Answers'][3]['Answers'];
  }


  @override
  void initState() {
    getCurrentUser();
    super.initState();
    updateUI(widget.quizes);
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/quiz.jpg"), fit: BoxFit.cover,
        ),
      ),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(20.0),),
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(" Question ${qno + 1} of $length ",
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      Text(" Score : $score",
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0),),

                Image.asset("images/${images[qno]}.jpg"),

                Padding(padding: EdgeInsets.all(10.0),),
                Text(
                  '$que',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),),
                Padding(padding: EdgeInsets.all(10.0),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    //button 1
                     Flexible(
                       child: Container(
                         child: ChoiceButton(
                          colour: Color(0xFFE52883),
                          onPress: (){
                            if(widget.quizes['Quiz Questions'][qno]['Answers'][0]['isTrue'].toString() == 'true') {
                              debugPrint("true");
                              score++;
                            }else{
                              debugPrint("false");
                            }
                            upQno();
                            updateUI(widget.quizes);
                          },
                          label: '$ch1',
                         ),
                       ),
                     ),

                    Padding(padding: EdgeInsets.all(10.0)),

                    //button 2
                    Flexible(
                      child: Container(
                        child: ChoiceButton(
                          colour: Color(0xFFE52883),
                          onPress: (){
                            if(widget.quizes['Quiz Questions'][qno]['Answers'][1]['isTrue'].toString() == 'true') {
                              debugPrint("true");
                              score++;
                            }else{
                              debugPrint("false");
                            }
                            upQno();
                            updateUI(widget.quizes);
                          },
                          label: '$ch2',
                        ),
                      ),
                    ),
                  ],
                ),

                 Padding(padding: EdgeInsets.all(10.0)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    //button 3
                    Flexible(
                      child: Container(
                        child: ChoiceButton(
                          colour: Color(0xFFE52883),
                          onPress: (){
                            if(widget.quizes['Quiz Questions'][qno]['Answers'][2]['isTrue'].toString() == 'true') {
                              debugPrint("true");
                              score++;
                            }else{
                              debugPrint("false");
                            }
                            upQno();
                            updateUI(widget.quizes);
                          },
                          label: '$ch3',
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(10.0)),

                    //button 4
                    Flexible(
                      child: Container(
                        child: ChoiceButton(
                          colour: Color(0xFFE52883),
                          onPress: (){
                            if(widget.quizes['Quiz Questions'][qno]['Answers'][3]['isTrue'].toString() == 'true') {
                              debugPrint("true");
                              score++;
                            }else{
                              debugPrint("false");
                            }
                            upQno();
                            updateUI(widget.quizes);
                          },
                          label: '$ch4',
                        ),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  void resetQuiz(){
    setState(() {
      Navigator.pop(context);
      score = 0;
      qno = 0;
    });
  }

  void upQno(){
    setState(() {
      if(qno == length - 1){
        Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Summary(points: score,)));
      }else{
        qno++;
      }
    });
  }

}


class Summary extends StatelessWidget{
  final int points;
  Summary({Key key, @required this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/final.jpg"), fit: BoxFit.cover,
          ),
        ),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text(
                  "Final Score: $points / 5",
                  style: new TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                  ),),

                Padding(padding: EdgeInsets.all(30.0)),

                RoundedButton(
                  colour: Colors.red,
                  onPress: (){
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                  label: "Reset Quiz",
                ),

              ],
            ),
          ),


        ),
      ),
    );
  }


}


