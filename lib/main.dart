import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'screens/screen_a.dart';
import 'screens/screen_b.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Class (Cupertino)',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/screen_a': (context) => const ScreenA(),
        '/screen_b': (context) => const ScreenB(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _imageUrls = [
    'assets/home.jpg',
    'assets/home.jpg',
    'assets/home.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Home"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Welcome to the App!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: _imageUrls.map((imageUrl) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: CupertinoColors.systemGrey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(imageUrl, fit: BoxFit.cover),
                  ),
                );
              }).toList(),
            ),
            CupertinoButton.filled(
              onPressed: () => Navigator.pushNamed(context, '/screen_b'),
              child: const Text("Go to GridView"),
            ),
            const SizedBox(height: 10),
            CupertinoButton.filled(
              onPressed: () => Navigator.pushNamed(context, '/screen_a'),
              child: const Text("Go to ListView"),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.5),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/home.jpg',
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("card with image"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
