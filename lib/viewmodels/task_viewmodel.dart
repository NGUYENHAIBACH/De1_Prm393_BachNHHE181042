import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/database_helper.dart';
import '../data/task_repository.dart';
import '../models/task.dart';

part 'task_viewmodel.g.dart';

@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) {
  return TaskRepository(DatabaseHelper.instance);
}

@Riverpod(keepAlive: true)
class TaskList extends _$TaskList {
  @override
  Future<List<Task>> build() async {
    return ref.read(taskRepositoryProvider).getAll();
  }

  Future<void> updateTask(Task task) async {
    await ref.read(taskRepositoryProvider).update(task);
    ref.invalidateSelf();
    await future;
  }

  Future<void> addTask(Task task) async {
    await ref.read(taskRepositoryProvider).insert(task);
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void set(String value) => state = value;
}

@riverpod
AsyncValue<List<Task>> filteredTasks(Ref ref) {
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final tasks = ref.watch(taskListProvider);
  if (query.isEmpty) return tasks;
  return tasks.whenData((list) => list
      .where((t) =>
          t.title.toLowerCase().contains(query) ||
          t.description.toLowerCase().contains(query))
      .toList());
}
