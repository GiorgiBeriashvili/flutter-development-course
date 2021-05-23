import 'package:assignment_05/logic/blocs/blocs.dart';
import 'package:assignment_05/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatelessWidget {
  static const routeName = '/posts';

  final int userId;

  const PostsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostLoadFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.exception.message),
                  backgroundColor: Colors.red,
                ),
              );
            }

            if (state is PostDeletedSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is PostLoadInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostLoadSuccess) {
              return ListView.separated(
                itemCount: state.posts.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final post = state.posts[index];

                  return Dismissible(
                    key: Key('${post.id}'),
                    child: ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    ),
                    onDismissed: (direction) {
                      context.read<PostBloc>().add(
                            PostDeleted(
                              posts: state.posts,
                              postId: post.id,
                            ),
                          );
                    },
                    confirmDismiss: (direction) => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Remove the post'),
                        content: Text('Would you like to remove the post?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text('Cancel')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Confirm')),
                        ],
                      ),
                    ),
                    background: Container(color: Theme.of(context).errorColor),
                  );
                },
              );
            } else {
              return Center(
                child: ElevatedButton.icon(
                  onPressed: () => context.read<PostBloc>().add(
                        PostStarted(userId: userId),
                      ),
                  icon: Icon(Icons.replay),
                  label: Text('Retry'),
                ),
              );
            }
          },
        ),
        floatingActionButton: BlocBuilder(
          bloc: BlocProvider.of<PostBloc>(context),
          builder: (context, state) {
            if (state is PostLoadSuccess) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => Navigator.of(context)
                    .pushNamed(
                  AddPostScreen.routeName,
                  arguments: userId,
                )
                    .then(
                  (post) async {
                    if (post != null) {
                      context.read<PostBloc>().add(
                            PostCreated(
                              posts: state.posts,
                              post: post as Map<String, dynamic>,
                            ),
                          );
                    }
                  },
                ),
              );
            }

            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: null,
              backgroundColor: Colors.grey,
            );
          },
        ),
      );
}
