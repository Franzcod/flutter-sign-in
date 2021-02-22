import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {

  CustomButton({
    this.child,
    this.color,
    this.borderRadius : 8.0,
    this.height : 50.0,
    this.onPressed
  });

  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
            shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          ),
          child: child,
          onPressed: onPressed
      ),
    );
  }
}
