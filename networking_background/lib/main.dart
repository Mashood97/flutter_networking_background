import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:networking_background/post/controller/post_controller.dart';
import 'package:networking_background/post/repo/post_repository.dart';
import 'package:networking_background/post/view/post_view.dart';

import 'networking/dio_client/dio_client.dart';

void main() {
  Get.lazyPut<PostController>(
      () => PostController(postRepository: Get.find<PostRepository>()),
      fenix: true);
  Get.lazyPut<PostRepository>(
      () => PostRepositoryImpl(dioClient: Get.find<DioClient>()),
      fenix: true);
  Get.lazyPut<DioClient>(
      () => DioClient(
            dio: Dio(),
          ),
      fenix: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostView(),
    );
  }
}
