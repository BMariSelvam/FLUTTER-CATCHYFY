import 'dart:async';
import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  bool animate = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    startAnimation();
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 5500,
      ),
      reverseDuration: const Duration(milliseconds: 2000),
      vsync: this,
      // value: 1,
    );
    _animation = Tween<double>(begin: 1.2, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
                duration: const Duration(milliseconds: 2500),
                bottom: animate ? 300 : 0,
                right: animate ? 80 : 0,
                child: ScaleTransition(
                    scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/image 157.png')))),
            AnimatedPositioned(
                left: animate ? 70 : 0,
                bottom: animate ? 325 : 215,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/image 152.png')))),
            AnimatedPositioned(
                left: animate ? 80 : 20,
                bottom: animate ? 325 : 25,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/image 154.png')))),
            AnimatedPositioned(
                right: animate ? 80 : 30,
                bottom: animate ? 325 : 130,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/image 153.png')))),
            AnimatedPositioned(
                left: animate ? 125 : 125,
                bottom: animate ? 325 : 210,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/Group (1).png')))),
            AnimatedPositioned(
                right: animate ? 70 : 20,
                bottom: animate ? 350 : 275,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/Group.png')))),
            AnimatedPositioned(
                left: animate ? 70 : 10,
                bottom: animate ? 350 : 375,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/Group (3).png')))),
            AnimatedPositioned(
                top: animate ? 310 : 0,
                right: animate ? 135 : 0,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/image 158.png')))),
            AnimatedPositioned(
                left: animate ? 150 : 0,
                top: animate ? 270 : 0,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/image 156.png')))),
            AnimatedPositioned(
                right: animate ? 120 : 0,
                top: animate ? 300 : 155,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/image 151.png')))),
            AnimatedPositioned(
                right: animate ? 150 : 110,
                top: animate ? 310 : 45,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/image 155.png')))),
            AnimatedPositioned(
                right: animate ? 150 : 0,
                top: animate ? 320 : 295,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/Group (2).png')))),
            AnimatedPositioned(
                left: animate ? 95 : 0,
                top: animate ? 330 : 225,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/Group (4).png')))),
            AnimatedPositioned(
                left: animate ? 100 : 25,
                top: animate ? 280 : 135,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: RotationTransition(turns: _animation,
                        child: Image.asset('assets/image/image 150.png')))),
            AnimatedPositioned(
                top: animate ? 300 : 170,
                left: 170,
                duration: const Duration(milliseconds: 2500),
                child: ScaleTransition(scale: _animation,
                    child: Image.asset('assets/image/Group (5).png'))),
            AnimatedPositioned(
                curve: Curves.bounceOut,
                duration: const Duration(milliseconds: 2600),
                 bottom: animate ? height(context)/2.2 : -50,
                // right: 60,
                child: AnimatedOpacity(opacity: animate? 1 : 0.0,
                    duration: const Duration(milliseconds: 2800),
                    child: Align(alignment: animate? Alignment.center : Alignment.bottomCenter,
                        child: Image.asset("assets/image/Asset 5@2x-600 1.png",scale: 1.5,)))),
          ],
        ));
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      animate = true;
    });
    await Future.delayed(const Duration(milliseconds: 4650));
    Get.toNamed(AppRoutes.welcomeScreen);
  }
}