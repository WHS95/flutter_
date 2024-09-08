import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});
  final TextEditingController introController = TextEditingController();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isEditButtonTapped = false;

  @override
  void initState() {
    super.initState();
    _getIntroduceMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.accessibility_new),
        title: const Text(
          '문제 해결사 서우혁',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileImage(),
            _buildInfoSection('이름', '서우혁'),
            _buildInfoSection('나이', '29'),
            _buildInfoSection('취미', '러닝'),
            _buildInfoSection('학력', '학부생'),
            _buildInfoSection('MBTI', 'ESTJ'),
            _buildIntroduceSection(),
            _buildIntroduceTextField(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/profile_whs.jpeg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildInfoSection(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildIntroduceSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, top: 16),
          child: const Text('자기소개'),
        ),
        GestureDetector(
          onTap: _toggleEditMode,
          child: Container(
            margin: const EdgeInsets.only(right: 16, top: 16),
            child: Icon(
              Icons.edit,
              size: 20,
              color: _isEditButtonTapped
                  ? Colors.black
                  : const Color.fromARGB(255, 54, 142, 214),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIntroduceTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: widget.introController,
        enabled: _isEditButtonTapped,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          hintText: '자기소개를 입력해주세요',
        ),
      ),
    );
  }

  Future<void> _getIntroduceMessage() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String? introduceMessage = sharedPreferences.getString('introduceMessage');
    widget.introController.text = introduceMessage ?? "";
  }

  void _toggleEditMode() async {
    setState(() {
      _isEditButtonTapped = !_isEditButtonTapped;
    });
    if (_isEditButtonTapped && widget.introController.text.isEmpty) {
      var snackBar = const SnackBar(
        content: Text('자기소개를 입력해주세요'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (_isEditButtonTapped) {
      var introduceMessage = await SharedPreferences.getInstance();
      introduceMessage.setString(
          'introduceMessage', widget.introController.text);
    }
  }
}
