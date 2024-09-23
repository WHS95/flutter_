import 'package:flutter/material.dart';
import 'package:flutter_app/data/idea_info.dart';
import 'package:flutter_app/database/database_helper.dart'; // Assuming DatabaseHelper is in this package

class EditScreen extends StatefulWidget {
  final IdeaInfo? idea;
  const EditScreen({super.key, this.idea});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController motivationController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();
  final TextEditingController userFeedbackController = TextEditingController();
  int selectedScore = 0; // 추가된 변수

  // 데이터베이스 헬퍼 인스턴스 생성
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // 저장 버튼을 눌렀을 때 호출되는 함수
  void _saveIdea() async {
    Map<String, dynamic> idea = {
      'title': titleController.text,
      'motive': motivationController.text,
      'content': contentController.text,
      'priority': selectedScore,
      'feedback': userFeedbackController.text,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    };

    await _databaseHelper.insertIdeaInfo(idea);
    Navigator.pop(context); // 저장 후 이전 화면으로 돌아가기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: const Text(
          '새 아이디어 작성하기',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '제목',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: '제목을 입력하세요',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 182, 179, 179),
                  ),
                ),
                controller: titleController,
              ),
              const Text('아이디어 발생 계기'),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: '아이디어 발생 계기를 적어주세요',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 182, 179, 179),
                  ),
                ),
                controller: motivationController,
              ),
              const SizedBox(
                height: 6,
              ),
              const Text('아이디어 내용'),
              TextField(
                maxLines: 5,
                maxLength: 500,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: '아이디어 내용을 적어주세요',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 182, 179, 179),
                  ),
                ),
                controller: contentController,
              ),
              const SizedBox(
                height: 6,
              ),
              const Text('아이디어 점수'),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  int score = index + 1;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedScore == score
                          ? Colors.blue
                          : Colors.white, // 기본 선택 안했을 시 흰색 배경
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: selectedScore == score
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                      minimumSize: const Size(50, 50), // 정사각형 모양
                    ),
                    onPressed: () {
                      setState(() {
                        selectedScore = score;
                      });
                    },
                    child: Text(
                      '$score',
                      style: TextStyle(
                        color: selectedScore == score
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text('유저피드백 상황(선택)'),
              TextField(
                maxLines: 5,
                maxLength: 500,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: '떠오르신 아이디어 기반으로\n 전달받은 피드백을 적어주세요',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 182, 179, 179),
                  ),
                ),
                controller: userFeedbackController,
              ),
              ElevatedButton(
                onPressed: _saveIdea,
                child: const Text('저장'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
