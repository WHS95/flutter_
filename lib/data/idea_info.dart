import 'package:flutter/material.dart';

class IdeaInfo {
  int? id;
  String title;
  String motive;
  String content;
  int priority;
  String feedback;
  int createdAt;

  IdeaInfo({
    this.id,
    required this.title,
    required this.motive,
    required this.content,
    required this.priority,
    required this.feedback,
    required this.createdAt,
  });

  // Map으로 변환하는 메서드
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'motive': motive,
      'content': content,
      'priority': priority,
      'feedback': feedback,
      'createdAt': createdAt,
    };
  }

  // Map에서 객체를 생성하는 메서드
  factory IdeaInfo.fromMap(Map<String, dynamic> map) {
    return IdeaInfo(
      id: map['id'],
      title: map['title'],
      motive: map['motive'],
      content: map['content'],
      priority: map['priority'],
      feedback: map['feedback'],
      createdAt: map['createdAt'],
    );
  }
}
