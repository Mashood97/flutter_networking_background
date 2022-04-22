import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:networking_background/post/model/post_model.dart';

import '../../networking/dio_client/dio_client.dart';
import '../../networking/exception/http_exception.dart';

abstract class PostRepository {
  Future<List<PostModel>> getPosts();
}

//This will run in background thread for better performance.

List<PostModel> parsedPostResponse(String responseBody) {
  log("Info: Parsing in background");
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<PostModel>((json) => PostModel.fromJson(json)).toList();
}

class PostRepositoryImpl extends PostRepository {
  final DioClient dioClient;
  PostRepositoryImpl({required this.dioClient});
  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final response = await dioClient.get("posts");
      return compute(parsedPostResponse, jsonEncode(response));
    } on HttpException catch (e) {
      throw e.message;
    }
  }
}
