import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_app/database/database_helper.dart';
import 'package:flutter_app/data/idea_info.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key}); // 생성자

  @override
  State<MainScreen> createState() => _MyWidgetState(); // 상태 생성
}

class _MyWidgetState extends State<MainScreen> {
  late Future<List<IdeaInfo>> _ideas;

  @override
  void initState() {
    super.initState();
    _ideas = getIdeaInfo(); // 데이터베이스에서 아이디어 목록을 가져옴
  }

  Future<List<IdeaInfo>> getIdeaInfo() async {
    List<IdeaInfo> ideas = await DatabaseHelper().getAllIdeaInfo();
    ideas.sort(
        (a, b) => b.createdAt.compareTo(a.createdAt)); // createdAt을 기준으로 역순 정렬
    return ideas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Scaffold의 배경색을 흰색으로 설정
      appBar: AppBar(
        title: const Text(
          "Achieve Idea",
          style: TextStyle(
            fontSize: 24, // 글자 크기
            fontWeight: FontWeight.bold, // 글자 굵기
            color: Colors.black, // 글자 색상
          ),
        ),
        backgroundColor: Colors.white, // AppBar의 배경색을 흰색으로 설정
        elevation: 0, // 그림자 높이 설정
      ),
      body: Container(
        margin: const EdgeInsets.all(16), // 외부 여백 설정
        child: ListView.builder(
          itemCount: 10, // 아이템 개수
          itemBuilder: (context, index) {
            return listItem(index); // 리스트 아이템 생성
          },
        ),
      ),
      //floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/edit');
        },
        backgroundColor: Colors.purple.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // 버튼을 둥글게 설정
        ),
        child: Image.asset(
          'assets/business-card.png',
          width: 30, // 버튼 크기를 더 크게 설정
          height: 30, // 버튼 크기를 더 크게 설정
        ),
      ),
    );
  }

  // 리스트 아이템을 생성하는 함수
  Widget listItem(int index) {
    return Container(
      height: 82, // 높이 설정
      margin: const EdgeInsets.only(top: 16), // 리스트 아이템 간의 간격을 조정
      decoration: ShapeDecoration(
        color: Colors.white, // 배경색을 흰색으로 설정
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 1), // 테두리 설정
          borderRadius: BorderRadius.circular(10), // 모서리 둥글게 설정
        ),
      ),
      child: Stack(
        alignment: Alignment.centerLeft, // 텍스트를 왼쪽으로 정렬
        children: [
          // 아이디어 제목
          Container(
            margin: const EdgeInsets.only(left: 16, bottom: 20), // 'const' 추가
            child: const Text(
              "#환경보호 아이디어 만들기",
              style: TextStyle(fontSize: 16), // 글자 크기 설정
            ),
          ),
          // 아이디어 일시
          const Positioned(
            right: 16,
            bottom: 16,
            child: Text("2024-05-01"),
          ),
          // 아이디어 중요도 점수
          Positioned(
            left: 10, // 왼쪽 여백 설정
            bottom: 10, // 아래쪽 여백 설정
            child: RatingBar.builder(
              initialRating: 3, // 초기 평점 설정
              minRating: 1, // 최소 평점 설정
              direction: Axis.horizontal, // 평점 방향 설정
              allowHalfRating: true, // 반 평점 허용
              itemCount: 5, // 별 개수 설정
              itemSize: 16, // 별의 크기를 작게 설정
              itemPadding:
                  const EdgeInsets.symmetric(horizontal: 1.0), // 별 사이의 간격 설정
              itemBuilder: (context, _) => const Icon(
                Icons.star, // 별 아이콘 설정
                color: Colors.amber, // 별 색상 설정
              ),
              onRatingUpdate: (rating) {
                print(rating); // 평점 업데이트 시 콘솔에 출력
              },
            ),
          ),
        ],
      ),
    );
  }
}
