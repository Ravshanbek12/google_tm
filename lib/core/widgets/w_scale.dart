import 'package:flutter/material.dart';

class WScale extends StatefulWidget {
  final Function() onTap;
  final Widget child;
  const WScale({
    required this.onTap,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<WScale> createState() => _WScaleState();
}

class _WScaleState extends State<WScale> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scale;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    super.initState();

    scale = Tween<double>(begin: 1.0, end: 0.95).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onPanDown: (_) {
        animationController.forward();
        setState(() {});
      },
      onPanCancel: () {
        animationController.reverse();
        setState(() {});
      },
      onPanEnd: (_) {
        animationController.reverse();
        setState(() {});
      },
      child: ScaleTransition(
        scale: scale,
        child: widget.child,
      ),
    );
  }
}
