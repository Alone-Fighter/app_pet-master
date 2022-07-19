import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../constants.dart';



class Waitting extends StatefulWidget {
  const Waitting({Key? key}) : super(key: key);

  @override
  State<Waitting> createState() => _WaittingState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _WaittingState extends State<Waitting>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Container(
        width: 100.0,
        height: 100.0,
        child: Container(
          margin: EdgeInsets.all(5),
          width: 35.0,
          height: 35.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kDarkBlueHeader,
          ),
          child:  Center(
            child: Image.asset('assets/images/wlogo.png'),
          ),
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
  }
}
