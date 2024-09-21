import 'package:flutter/material.dart';
import 'package:flutter_app/data/idea_info.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
