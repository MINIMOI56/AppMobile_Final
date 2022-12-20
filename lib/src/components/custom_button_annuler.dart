//Boutton pour annuler avec un contour de couleur mauve

import 'package:flutter/material.dart';

class CustomButtonAnnuler extends StatelessWidget {
  const CustomButtonAnnuler({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color.fromARGB(255, 191, 0, 255),
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(50),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Color.fromARGB(255, 191, 0, 255),
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}