class Todo {
  Todo({
    required this.id,
    this.completed = false,
    this.content = '',
  });

  final String id;
  bool completed;
  String content;
}
