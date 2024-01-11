import 'package:flutter/material.dart';
import 'constants.dart';

class CardColumn extends StatelessWidget {
  final IconData icon;
  final String textstring;
  final Color iconcolor;

  const CardColumn({
    Key? key,
    required this.icon,
    required this.textstring,
    required this.iconcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80,
          color: iconcolor,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          textstring,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
