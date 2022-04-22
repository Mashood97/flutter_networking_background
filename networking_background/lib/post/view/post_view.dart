import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:networking_background/post/controller/post_controller.dart';

class PostView extends StatelessWidget {
  PostView({Key? key}) : super(key: key);
  final _postController = Get.find<PostController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Networking In Background"),
      ),
      body: SafeArea(
        child: Obx(() => _postController.isLoadingState
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ListView.separated(
                itemBuilder: (ctx, index) => ListTile(
                  title: Text(_postController.posts[index].title ?? ""),
                  subtitle: Text(_postController.posts[index].body ?? ""),
                ),
                separatorBuilder: (_, __) => const Divider(),
                itemCount: _postController.posts.length,
              )),
      ),
    );
  }
}
