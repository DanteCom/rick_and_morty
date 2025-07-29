import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/shared/shared.dart';
import 'package:rick_and_morty/app/router/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _opacity;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.addStatusListener((status) {
      if (status != AnimationStatus.completed) return;

      context.goNamed(AppRoutes.characters.name);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await precacheImage(const AssetImage(Images.splashBackground), context);

      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      constraints: BoxConstraints.expand(),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.splashBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: AnimatedBuilder(
        animation: _opacity,
        builder: (context, child) => Opacity(
          opacity: _opacity.value,
          child: Image.asset(width: double.infinity, Images.splashForeground),
        ),
      ),
    );
  }
}
