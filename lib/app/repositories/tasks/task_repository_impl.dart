import 'package:cto_todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:cto_todo_list_provider/app/repositories/tasks/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository{
final SqliteConnectionFactory _sqliteConnectionFactory;

TaskRepositoryImpl(
  {required SqliteConnectionFactory sqliteConnectionFactory}
) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    try {
    final conn = await  _sqliteConnectionFactory.openConnection();
  await conn.insert(
    'todo', {
      'id': null,
      'descricao': description,
      'data_hora': date.toIso8601String(),
      'finalizdo': 0
     });
} on Exception catch (e) {
  e.toString();
}
  }

}