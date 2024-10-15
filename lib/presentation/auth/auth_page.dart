import 'package:flutter/material.dart';
import 'package:gps_health_tracker/domain/repository/user_repository.dart';
import 'package:gps_health_tracker/infrastructure/firebase/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  final TextEditingController _nicknameController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _nicknameController.text.isNotEmpty;
    });
  }

  bool _validateNickname(String nickname) {
    return nickname.isNotEmpty;
  }

  void _onPressed() {
    final nickname = _nicknameController.text;

    if (!_validateNickname(nickname)) {
      _showErrorDialog('ニックネームを入力してください。');
      return;
    }

    

    // 匿名認証する
    FirebaseAuthInfra().signInAnonymously().then((userCredential) {
      // ユーザー情報を登録する
      UserRepository().registerUser(nickname, userCredential.user!.uid).then((_) {

      }).catchError((e) {
        print("Failed to register user: $e");
      });
    }).catchError((e) {
      print("Unexpected error occurred.");
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('エラー'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('認証'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'お名前(あだ名で構いません)',
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isButtonEnabled ? _onPressed : null,
                child: const Text('送信'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
