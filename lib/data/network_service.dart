import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  final baseUrl = "http://10.0.2.2:3000";

  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await http.get("${Uri.parse(baseUrl)}/todos");
      print(response.body);
      return jsonDecode(response.body) as List;
    } catch (e) {
      return [];
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, int id) async {
    try {
      await http.patch("$baseUrl/todos/$id", body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map> addTodo(Map<String, Object> todoObj) async {
    try {
      final response = await http.post("$baseUrl/todos", body: todoObj);
      return jsonDecode(response.body);
    } catch (e) {
      throw e;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      await http.delete("$baseUrl/todos/$id");
      return true;
    } catch (e) {
      return false;
    }
  }
}
