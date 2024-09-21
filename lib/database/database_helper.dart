import 'package:flutter_app/data/idea_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// 데이터베이스를 관리하는 헬퍼 클래스
class DatabaseHelper {
  // 싱글톤 패턴을 위한 인스턴스 변수
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // 데이터베이스 객체를 저장할 변수
  Database? _database;

  // 싱글톤 패턴을 적용하여 애플리케이션 전체에서 하나의 인스턴스를 사용
  factory DatabaseHelper() {
    return _instance;
  }

  // 프라이빗 생성자: 싱글톤 패턴을 위한 내부 생성자
  DatabaseHelper._internal();

  // 데이터베이스 객체를 비동기로 가져오는 getter
  Future<Database> get database async {
    // 데이터베이스가 초기화되지 않았다면 초기화합니다.
    if (_database == null) {
      _database = await _initDatabase(); // 데이터베이스 초기화 함수 호출
    }
    return _database!; // 초기화된 데이터베이스 객체 반환
  }

  // 데이터베이스 초기화 함수
  Future<Database> _initDatabase() async {
    // 데이터베이스 파일의 경로 설정 (이 경로에 데이터베이스 파일이 생성됨)
    String path = join(await getDatabasesPath(), 'my_database.db');

    // 데이터베이스를 열고, 만약 파일이 없다면 새로 생성합니다.
    return await openDatabase(
      path,
      version: 1, // 데이터베이스 버전 설정 (버전 관리를 통해 데이터베이스 구조 변경 관리 가능)
      onCreate: _onCreate, // 데이터베이스가 처음 생성될 때 호출될 함수 지정
    );
  }

  // 데이터베이스가 처음 생성될 때 호출되는 함수로, 테이블을 생성합니다.
  Future<void> _onCreate(Database db, int version) async {
    // 'ideas'라는 테이블 생성
    await db.execute('''
      CREATE TABLE ideas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        motive TEXT,
        content TEXT,
        priority INTEGER,
        feedback TEXT,
        createdAt INTEGER
      )
    ''');
  }

  // 새 아이디어를 데이터베이스에 삽입하는 함수
  Future<int> insertIdeaInfo(Map<String, dynamic> idea) async {
    final db = await database; // 데이터베이스 객체를 가져옴
    return await db.insert('ideas', idea); // 'ideas' 테이블에 새로운 레코드 삽입
  }

  // 데이터베이스에서 모든 아이디어를 조회하는 함수
  Future<List<Map<String, dynamic>>> getAllIdea() async {
    final db = await database; // 데이터베이스 객체를 가져옴
    return await db.query('ideas'); // 'ideas' 테이블에서 모든 레코드를 조회하여 반환
  }

  Future<List<IdeaInfo>> getAllIdeaInfo() async {
    final db = await database; // 데이터베이스 객체를 가져옴
    final List<Map<String, dynamic>> result = await db.query('ideas');
    return List.generate(
      result.length,
      (index) {
        return IdeaInfo.fromMap(result[index]);
      },
    );
  }

  // 특정 ID를 가진 아이디어를 조회하는 함수
  Future<IdeaInfo?> getIdeaById(IdeaInfo idea) async {
    final db = await database; // 데이터베이스 객체를 가져옴
    final List<Map<String, dynamic>> result = await db
        .query('ideas', where: 'id = ?', whereArgs: [idea.id]); // 조건에 맞는 레코드 조회
    if (result.isNotEmpty) {
      // 조회 결과가 있으면
      return IdeaInfo.fromMap(result.first);
    }
    return null; // 조회 결과가 없으면 null 반환
  }

  // 특정 ID를 가진 아이디어를 업데이트하는 함수
  Future<int> updateIdea(IdeaInfo idea) async {
    final db = await database; // 데이터베이스 객체를 가져옴
    return await db.update(
      'ideas',
      idea.toMap(),
      where: 'id = ?',
      whereArgs: [idea.id],
    ); // 조건에 맞는 레코드 업데이트
  }

  // 특정 ID를 가진 아이디어를 삭제하는 함수
  Future<int> deleteIdea(IdeaInfo idea) async {
    final db = await database; // 데이터베이스 객체를 가져옴
    return await db.delete(
      'ideas',
      where: 'id = ?',
      whereArgs: [idea.id],
    ); // 조건에 맞는 레코드 삭제
  }

  // 데이터베이스 연결을 닫는 함수
  Future<void> close() async {
    final db = await database; // 데이터베이스 객체를 가져옴
    await db.close(); // 데이터베이스 연결 닫기
  }
}
