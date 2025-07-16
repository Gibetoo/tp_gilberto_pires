class Post {
  final String? id;
  final String title;
  final String description;
  final DateTime? lastUpdatedAt;

  Post({
    this.id,
    required this.title,
    required this.description,
    this.lastUpdatedAt,
  });

  factory Post.fromMap(String id, Map<String, dynamic> data) {
    return Post(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      lastUpdatedAt: data['lastUpdatedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'lastUpdatedAt': lastUpdatedAt,
    };
  }

  Post copyWith({String? title, String? description, DateTime? lastUpdatedAt}) {
    return Post(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }
}
