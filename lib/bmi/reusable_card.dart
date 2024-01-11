import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  final VoidCallback? pressHandler;

  const ReusableCard({
    Key? key,
    required this.cardChild,
    // this.color = const Color(0xFF1D1E33),
    this.color = const Color(0xFF1C1C1E),
    this.pressHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressHandler,
      child: Container(
        height: 200,
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
          child: cardChild,
        ),
      ),
    );
  }
}

class ReusableCardPage2 extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  final VoidCallback? pressHandler;

  const ReusableCardPage2({
    Key? key,
    required this.cardChild,
    this.color = const Color(0xFF1D1E33),
    this.pressHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressHandler,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
          child: cardChild,
        ),
      ),
    );
  }
}
// child: const Center(
// child: Text(
// 'sağ alt Container',
// style: TextStyle(
// color: Colors.white,
// fontSize: 18,
// ),
// ),
// ),child: const Center(
// child: Text(
// 'sağ alt Container',
// style: TextStyle(
// color: Colors.white,
// fontSize: 18,
// ),
// ),
// ),
