import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatefulWidget {
  final VoidCallback;
  final IconData iconData;
  const CustomFloatingActionButton({super.key, this.VoidCallback, required this.iconData});

  @override
  State<CustomFloatingActionButton> createState() => _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed:widget.VoidCallback ,
      child: Icon(
        widget.iconData,
        color: Colors.black,
      ),
    );
  }
}
