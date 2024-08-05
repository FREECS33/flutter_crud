import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model.dart';

class ModelRepository {
  final String apiUrl;

  ModelRepository({required this.apiUrl
  });

  Future<void> createModel(Model model) async {
    final response = await http.post(
      Uri.parse('$apiUrl/post-model'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(model.toJson())
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create model');
    }
  }

  Future<Model> getModel(int id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/get-model/$id'),
      headers: <String, String>{
      },
    );

    if (response.statusCode == 200) {
      return Model.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load model');
    }
  }

  Future<void> updateModel(Model model) async {
    final response = await http.put(
      Uri.parse('$apiUrl/update-model'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update model');
    }
  }

  Future<void> deleteModel(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/delete-model'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(id)
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete model');
    }
  }

  Future<List<Model>> getAllModels() async {
    final response = await http.get(
      Uri.parse('$apiUrl/get-models'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Model>.from(l.map((model) => Model.fromJson(model)));
    } else {
      throw Exception('Failed to load models');
    }
  }
}