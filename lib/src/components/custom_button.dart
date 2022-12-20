import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 191, 0, 255),
            Color.fromARGB(255, 255, 165, 0)
          ],
          end: Alignment.topRight,
          begin: Alignment.bottomLeft,
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
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
