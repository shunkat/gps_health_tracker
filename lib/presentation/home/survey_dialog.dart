import 'package:flutter/material.dart';

class SurveyDialog extends StatefulWidget {
  final int currentSurveyVersion;

  const SurveyDialog({Key? key, required this.currentSurveyVersion})
      : super(key: key);

  @override
  _SurveyDialogState createState() => _SurveyDialogState();
}

class _SurveyDialogState extends State<SurveyDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? _gender;
  String? _walkingDisorders;
  String? _dementiaDiagnosis;
  String? _dementiaDiagnosisDetails;
  String? _exerciseHabit;
  String? _familyComposition;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _saveSurveyData() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    // TODO: Firestoreに保存する
    // String name = _nameController.text;
    // int? age = int.tryParse(_ageController.text);
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
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      // TODO: WillPopScopeではなく、PopScropeを使うようにする
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('協力者の方へのアンケート'),
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
                      // Conditional Question
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
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _saveSurveyData();
                          Navigator.of(context).pop();
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
