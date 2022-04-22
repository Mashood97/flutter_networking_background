import 'package:get/get.dart';
import 'package:networking_background/post/model/post_model.dart';
import 'package:networking_background/post/repo/post_repository.dart';

class PostController extends GetxController {
  final PostRepository postRepository;
  PostController({
    required this.postRepository,
  });

  final RxList<PostModel> _posts = RxList();
  List<PostModel> get posts => [..._posts];

  final RxBool _isLoadingState = false.obs;
  bool get isLoadingState => _isLoadingState.value;
  Future<void> getPostsFromServer() async {
    _isLoadingState.value = true;
    try {
      final response = await postRepository.getPosts();
      _posts.addAll(response);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    _isLoadingState.value = false;
  }

  @override
  void onInit() async {
    await getPostsFromServer();
    super.onInit();
  }
}
