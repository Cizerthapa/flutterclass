import 'package:classapp/main.dart';
import 'package:classapp/service/token_service.dart';
import 'package:flutter/cupertino.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final token = await TokenStorage.getToken();
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(child: CupertinoActivityIndicator()),
    );
  }
}
