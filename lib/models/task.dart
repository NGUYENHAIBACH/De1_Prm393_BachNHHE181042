class Task {
  final int? id;
  final String title;
  final String description;
  final bool isDone;
  final String icon;
  const Task({
    this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    this.icon = 'report',
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    String? icon,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      icon: icon ?? this.icon,
    );
  }


  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'is_done': isDone ? 1 : 0,
        'icon': icon,
      };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
        id: map['id'] as int?,
        title: map['title'] as String,
        description: (map['description'] as String?) ?? '',
        isDone: (map['is_done'] as int) == 1,
        icon: (map['icon'] as String?) ?? 'report',
      );
}
