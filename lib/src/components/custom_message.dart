//Un message animé qui zoom et rétrécit en boucle

import 'package:flutter/material.dart';

class CustomMessage extends StatefulWidget {
  final String text;

  CustomMessage({required this.text});

  @override
  _CustomMessageState createState() => _CustomMessageState();
}

class _CustomMessageState extends State<CustomMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1, end: 1.2).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Transform.scale(
        scale: _animation.value,
        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      )
      ),
    );
  }
}