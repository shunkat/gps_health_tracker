import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gps_health_tracker/presentation/setting/setting_page.dart';
import 'package:gps_health_tracker/presentation/home/survey_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

// 既存のアンケート回答者にも新しく回答して欲しくなったら、このバージョンを上げる
// TODO: constはファイルでまとめて管理する
const int currentSurveyVersion = 1;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _checkSurveyVersion();
  }

  Future<void> _checkSurveyVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? latestSurveyVersion = prefs.getInt('latest_survey_version');

    if (latestSurveyVersion == null ||
        latestSurveyVersion < currentSurveyVersion) {
      _showSurveyDialog();
    }
  }

  void _showSurveyDialog() {
    showDialog(
      context: context,
      // 誤タップでダイアログが閉じることを防止
      barrierDismissible: false,
      builder: (context) => const SurveyDialog(
        currentSurveyVersion: currentSurveyVersion,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // デバイスの戻るボタンを無効化
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ホームページ'),
          automaticallyImplyLeading: false, // AppBarの戻るボタンを非表示にする
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
                  text:
                      '以上でアンケートは終了です。\nあとはできるだけスマートフォンを持ち歩いていただければ嬉しいです。\n加藤より',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16.0,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
