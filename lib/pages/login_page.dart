import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:church_management_system/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(
                "assets/icon/icon.jpg",
                width: 150,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Welcome to\n Fire Ministries",
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ).animate().fadeIn(
                  delay: const Duration(seconds: 3),
                  duration: const Duration(seconds: 1))
            ],
          )
              .animate(delay: const Duration(seconds: 3))
              .custom(
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, -200 * value),
                      child: child,
                    );
                  })
              .effect(curve: Curves.fastLinearToSlowEaseIn),
          ElevatedButton.icon(
                  onPressed: () {
                    GoogleSignInProvider().googleLogin(context);
                  },
                  label: const Text("Sign in with Google"),
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ))
              .animate()
              .fadeIn(
                  delay: const Duration(seconds: 3),
                  duration: const Duration(seconds: 1)),
        ]);
  }
}
