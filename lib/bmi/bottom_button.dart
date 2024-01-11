import 'package:flutter/material.dart';
import 'constants.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      color: kBottomContainerColor,
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: kBottomContainerHeight,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: kLargeButtonStyle,
        ),
      ),
    );
  }
}
