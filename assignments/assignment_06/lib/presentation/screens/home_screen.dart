import 'package:assignment_06/core/constants.dart' as constants;
import 'package:assignment_06/logic/blocs/blocs.dart';
import 'package:assignment_06/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(constants.appTitle),
        ),
        body: BlocConsumer<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsLoadFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.exception.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is NewsLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsLoadSuccess) {
              return ListView.separated(
                itemCount: state.news.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final news = state.news[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColorLight,
                      child: const Icon(Icons.article),
                    ),
                    title: Text(news.name),
                    subtitle: Text(news.id.toString()),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        NewsReleaseScreen.routeName,
                        arguments: news,
                      );

                      context
                          .read<NewsReleaseBloc>()
                          .add(NewsReleaseStarted(id: news.id));
                    },
                  );
                },
              );
            } else {
              return Center(
                child: ElevatedButton.icon(
                  onPressed: () => context.read<NewsBloc>().add(NewsStarted()),
                  icon: const Icon(Icons.replay),
                  label: const Text('Retry'),
                ),
              );
            }
          },
        ),
      );
}
