import 'package:go_router/go_router.dart';
import 'package:tp_gilberto_pires/screens/views/post_detail_page.dart';
import 'package:tp_gilberto_pires/screens/views/post_form_page.dart';
import 'package:tp_gilberto_pires/screens/views/post_list_page.dart';
import 'package:tp_gilberto_pires/screens/page_not_found/page_not_found.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const PageNotFound(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PostListPage(),
    ),
    GoRoute(
      path: '/post/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return PostDetailPage(postId: id);
      },
    ),
    GoRoute(
      path: '/create',
      builder: (context, state) => const PostFormPage(),
    ),
  ],
);