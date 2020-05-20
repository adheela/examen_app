import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final Color colour;
  final Function onPress;
  final String label;

  ChoiceButton(
      {@required this.onPress, @required this.colour, @required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 120.0,
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}