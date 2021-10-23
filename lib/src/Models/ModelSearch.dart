import 'dart:convert';

class ModelSearch {
  String key;
  ModelSearch(this.key);
  ModelSearch.New({required this.key});
  factory ModelSearch.fromJson(Map<String, dynamic> jsonData) {
    return ModelSearch.New(
      key: jsonData['key'],
    );
  }

  static Map<String, dynamic> toMap(ModelSearch search) => {'key': search.key};
  static String encode(List<ModelSearch> list) => json.encode(
        list.map<Map<String, dynamic>>((data) => ModelSearch.toMap(data)).toList(),
      );

  static List<ModelSearch> decode(String data) =>
      (json.decode(data) as List<dynamic>).map<ModelSearch>((item) => ModelSearch.fromJson(item)).toList();
}
