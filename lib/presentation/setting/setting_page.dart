import 'package:flutter/material.dart';
import 'package:gps_health_tracker/presentation/widgets/survey_dialog.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('設定ページ'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showSurveyDialog(context);
              },
              child: const Text('アンケート再回答'),
            ),
          ],
        ),
      ),
    );
  }
}
