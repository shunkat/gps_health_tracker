import 'package:flutter/material.dart';
import 'package:gps_health_tracker/presentation/setting/setting_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '実験へのご協力ありがとうございます。\n',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 24.0,
                    ),
              ),
              TextSpan(
                text: '以上でアンケートは終了です。\nあとはできるだけスマートフォンを持ち歩いていただければ嬉しいです。\n加藤より',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16.0,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
