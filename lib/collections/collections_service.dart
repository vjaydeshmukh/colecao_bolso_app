import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../config/application.dart';

import 'collection_model.dart';

class CollectionsService {
  final http.Client httpClient;
  CollectionsService({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Collection>> fetch(int startIndex, int limit) async {
    final response = await httpClient.get(
        '${Application.apiUri}/collections?_start=$startIndex&_limit=$limit');

    if (response.statusCode != 200)
      throw 'Não foi possível recuperar as coleções, tente novamente.';

    final data = json.decode(response.body) as List;
    return data.map((item) => Collection.fromMap(item)).toList();
  }

  Future<void> delete(int collectionId) async {
    final response = await httpClient
        .delete('${Application.apiUri}/collections/$collectionId');

    if (response.statusCode != 200)
      throw 'Não foi possível deletar a coleção, tente novamente.';
  }

  Future<void> toggleFav(int collectionId) async {
    await Future.delayed(Duration(seconds: 1));
    return;

    // final response = await httpClient
    //     .put('${Application.apiUri}/collections/$collectionId', {isFav: false});

    // if (response.statusCode != 200)
    //   throw 'Não foi possível deletar a coleção, tente novamente.';
  }

  Future<void> add(Collection model) async {
    var response = await httpClient.post('${Application.apiUri}/collections/',
        body: json.encode(model.toMap()));

    if (response.statusCode != 201)
      throw 'Não foi possível criar a coleção, tente novamente.';
  }

  Future<List<Collection>> fetchAll() async {
    final response = await httpClient.get(
        '${Application.apiUri}/collections');

    if (response.statusCode != 200)
      throw 'Não foi possível recuperar as coleções, tente novamente.';

    final data = json.decode(response.body) as List;
    return data.map((item) => Collection.fromMap(item)).toList();
  }
}
