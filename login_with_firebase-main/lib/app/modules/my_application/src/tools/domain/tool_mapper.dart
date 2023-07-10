import 'dart:convert';

import 'tool_entity.dart';

abstract class ToolMapper {
  
  static Map<String, dynamic> entityToMap(ToolEntity tool) {
    return {
      'tId': tool.tId,
      'name': tool.name,
      'type': tool.type,
      'amount': tool.amount,
      'userId' : tool.userId,
    };
  }

  static String entityToJson(ToolEntity tool) {
    var map = entityToMap(tool);
    return mapToJson(map);
  }

  static ToolEntity mapToEntity(Map<String, dynamic> map) {
    return ToolEntity(
      tId: map['tId'],
      name: map['name'],
      type: map['type'],
      amount: map['amount'],
      userId:map['userId'],
    );
  }

  static String mapToJson(Map<String, dynamic> map) => jsonEncode(map);
  static Map<String, dynamic> jsonToMap(String json) => jsonDecode(json);
  static ToolEntity jsonToEntity(String json) {
    var map = jsonToMap(json);
    return mapToEntity(map);
  }
}
