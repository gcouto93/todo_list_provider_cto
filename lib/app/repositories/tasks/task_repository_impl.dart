import 'package:cto_todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:cto_todo_list_provider/app/models/task_model.dart';
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

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0,0,0);
    final endFilter = DateTime(end.year, end.month, end.day, 23,59,59);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result =await  conn.rawQuery('''
      select *
      from todo
      where data_hora between ? and ?
      order by data_hora
    ''', [
      startFilter.toIso8601String(),
      endFilter.toIso8601String()
    ]);
    return result.map((e) => TaskModel.LoadFromDB(e)).toList();
  }

}