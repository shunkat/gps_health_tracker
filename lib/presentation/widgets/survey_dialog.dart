import 'package:flutter/material.dart';
import 'package:gps_health_tracker/domain/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveyDialog extends StatefulWidget {
  const SurveyDialog({super.key});
  

  @override
  _SurveyDialogState createState() => _SurveyDialogState();
}

class _SurveyDialogState extends State<SurveyDialog> {
  final _formKey = GlobalKey<FormState>();

  // コントローラーの定義
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _smokingPerDayController = TextEditingController();
  final TextEditingController _smokingYearsController = TextEditingController();

  // 状態変数の定義
  String? _gender;
  String? _walkingDisorders;
  String? _dementiaDiagnosis;
  String? _dementiaDiagnosisDetails;
  String? _exerciseHabit;
  String? _familyComposition;
  String? _address;
  String? _isEmployed;
  String? _smokingPerDay;
  String? _smokingYears;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _smokingPerDayController.dispose();
    _smokingYearsController.dispose();
    super.dispose();
  }

  Future<void> _saveSurveyData() async {
    // バリデーション
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    try {
      // SharedPreferences を使用して latest_survey_version を currentSurveyVersion で上書き
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('latest_survey_version', currentSurveyVersion);

      // TODO: Firestore にデータを保存する
      // 例:
      // String name = _nameController.text;
      // int? age = int.tryParse(_ageController.text);
      // String? address = _addressController.text;
      // String? isEmployed = _isEmployed;
      // int? smokingPerDay = int.tryParse(_smokingPerDayController.text);
      // int? smokingYears = int.tryParse(_smokingYearsController.text);
      // String? gender = _gender;
      // String? walkingDisorders = _walkingDisorders;
      // String? dementiaDiagnosis = _dementiaDiagnosis;
      // String? dementiaDiagnosisDetails = _dementiaDiagnosisDetails;
      // String? exerciseHabit = _exerciseHabit;
      // String? familyComposition = _familyComposition;

      // Firestore 保存ロジックをここに追加

      // 成功メッセージを表示（任意）
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('アンケートが正常に送信されました。')),
      );

      // ダイアログを閉じる
      Navigator.of(context).pop();
    } catch (e) {
      // エラーハンドリング
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('設定の保存に失敗しました。再度お試しください。')),
      );
    }
  }

  Widget _buildTextFormField({
    String? labelText,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    FormFieldSetter<String>? onSaved,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
    );
  }

  Widget _buildDropdownFormField({
    String? labelText,
    String? value,
    required List<String> items,
    ValueChanged<String?>? onChanged,
    FormFieldValidator<String>? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: labelText),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 戻るボタンを無効化
      onWillPop: () async => false,
      child: Dialog(
        insetPadding: const EdgeInsets.all(10),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('協力者の方へのアンケート'),
            automaticallyImplyLeading: false, // 戻るボタンを非表示にする
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('以下の質問にお答えください。'),
                    const SizedBox(height: 16),
                    // 1. 名前（ニックネームでも可能）
                    _buildTextFormField(
                      labelText: 'お名前（ニックネームでも可能）',
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'お名前を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // 2. 年齢
                    _buildTextFormField(
                      labelText: '年齢',
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '年齢を入力してください';
                        }
                        if (int.tryParse(value) == null) {
                          return '正しい年齢を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // 3. 性別
                    _buildDropdownFormField(
                      labelText: '性別',
                      value: _gender,
                      items: ['男性', '女性', 'その他', '回答しない'],
                      onChanged: (value) => setState(() => _gender = value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '性別を選択してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // 4. 歩行に関する持病
                    _buildTextFormField(
                      labelText: '歩行に関する持病',
                      onSaved: (value) => _walkingDisorders = value,
                    ),
                    const SizedBox(height: 16),
                    // 5. 認知症という診断を今まで受けたかどうか
                    _buildDropdownFormField(
                      labelText: '認知症という診断を今まで受けたかどうか',
                      value: _dementiaDiagnosis,
                      items: ['はい', 'いいえ'],
                      onChanged: (value) =>
                          setState(() => _dementiaDiagnosis = value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '選択してください';
                        }
                        return null;
                      },
                    ),
                    if (_dementiaDiagnosis == 'はい') ...[
                      const SizedBox(height: 16),
                      // 条件付き質問
                      _buildTextFormField(
                        labelText:
                            'どのような診断を受けたかを差し支えない範囲で教えてください。',
                        onSaved: (value) =>
                            _dementiaDiagnosisDetails = value,
                      ),
                    ],
                    const SizedBox(height: 16),
                    // 6. 普段の運動状況
                    _buildTextFormField(
                      labelText: '普段の運動状況',
                      onSaved: (value) => _exerciseHabit = value,
                    ),
                    const SizedBox(height: 16),
                    // 7. 家族構成
                    _buildDropdownFormField(
                      labelText: '家族構成',
                      value: _familyComposition,
                      items: ['一人暮らし', '家族と同居', 'その他'],
                      onChanged: (value) =>
                          setState(() => _familyComposition = value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '家族構成を選択してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // 8. 住所（任意）
                    _buildTextFormField(
                      labelText: '住所（任意）',
                      controller: _addressController,
                      // バリデーションなしで任意入力
                    ),
                    const SizedBox(height: 16),
                    // 9. 仕事をしているか？
                    _buildDropdownFormField(
                      labelText: '仕事をしているか？',
                      value: _isEmployed,
                      items: ['はい', 'いいえ'],
                      onChanged: (value) => setState(() => _isEmployed = value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '選択してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // 10. 喫煙歴（一日何本 x 何年間）
                    const Text(
                      '喫煙歴（一日何本 x 何年間）',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 一日何本吸うか
                    _buildTextFormField(
                      labelText: '一日に吸う本数',
                      controller: _smokingPerDayController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '一日に吸う本数を入力してください';
                        }
                        if (int.tryParse(value) == null) {
                          return '正しい数値を入力してください';
                        }
                        return null;
                      },
                      onSaved: (value) => _smokingPerDay = value,
                    ),
                    const SizedBox(height: 8),
                    // 喫煙年数
                    _buildTextFormField(
                      labelText: '喫煙年数',
                      controller: _smokingYearsController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '喫煙年数を入力してください';
                        }
                        if (int.tryParse(value) == null) {
                          return '正しい数値を入力してください';
                        }
                        return null;
                      },
                      onSaved: (value) => _smokingYears = value,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _saveSurveyData();
                          // Navigator.of(context).pop(); // ダイアログを閉じる処理は _saveSurveyData 内で行います
                        },
                        child: const Text('送信'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ダイアログを表示する関数の例
void showSurveyDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // 外部タップでダイアログが閉じないようにする
    builder: (BuildContext context) {
      return const SurveyDialog();
    },
  );
}
