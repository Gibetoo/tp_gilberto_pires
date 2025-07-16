import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tp_gilberto_pires/data/repositories/firestore_posts_data_source.dart';
import 'package:tp_gilberto_pires/data/repositories/post_repository.dart';
import 'package:tp_gilberto_pires/features/post/blocs/post_bloc.dart';
import 'package:tp_gilberto_pires/features/post/blocs/post_event.dart';
import 'package:tp_gilberto_pires/router/app_router.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        return RepositoryProvider(
          create: (context) => PostsRepository(FirestorePostsDataSource()),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create:
                    (context) =>
                        PostBloc(repository: context.read<PostsRepository>())
                          ..add(PostFetched()),
              ),
            ],
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'TP Firebase Posts',
              theme: ThemeData(primarySwatch: Colors.indigo),
              routerConfig: appRouter,
            ),
          ),
        );
      },
    );
  }
}
