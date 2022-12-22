//classique button back

import 'package:flutter/material.dart';

class CustomButtonBack extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButtonBack({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(
      left:20,
      top: 20
    ), 
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 70, 70, 70),
        onPrimary: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ));
  }
}