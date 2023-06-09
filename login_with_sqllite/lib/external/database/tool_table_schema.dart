import 'package:login_with_sqllite/external/database/user_table_schema.dart';

abstract class ToolTableSchema {

  static const String nameTable = 'tool';
  static const String toolIdColumn = 'id';
  static const String toolUserIdColumn  ='userId';
  static const String toolNameColumn = 'name';
  static const String toolAmountColumn = 'amount';

  static String createToolTableScript() => '''
    CREATE TABLE $nameTable (
          $toolIdColumn INTEGER PRIMARY KEY AUTOINCREMENT,
          $toolUserIdColumn TEXT NOT NULL,
          $toolNameColumn TEXT NOT NULL,
          $toolAmountColumn TEXT NOT NULL,
          FOREIGN KEY ($toolUserIdColumn) REFERENCES ${UserTableSchema.nameTable}(${UserTableSchema.userIDColumn})
        )
      ''';

}