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

  factory Post.fromJson(String id, Map<String, dynamic> json) {
    return Post(
      id: id,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      lastUpdatedAt: json['lastUpdatedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
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
