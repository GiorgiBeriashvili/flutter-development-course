import 'dart:io';

import 'package:assignment_06/data/models/models.dart';
import 'package:assignment_06/logic/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsReleaseScreen extends StatefulWidget {
  static const routeName = '/news';

  final News news;

  const NewsReleaseScreen({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  _NewsReleaseScreenState createState() => _NewsReleaseScreenState();
}

class _NewsReleaseScreenState extends State<NewsReleaseScreen> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.news.name,
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: BlocConsumer<NewsReleaseBloc, NewsReleaseState>(
          listener: (context, state) {
            if (state is NewsReleaseLoadFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.exception.message),
                  backgroundColor: Theme.of(context).errorColor,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is NewsReleaseLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsReleaseLoadSuccess) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2.00,
                      child: Image.network(
                        'https:' + state.newsRelease.imageUrl,
                        loadingBuilder: (context, child, loadingProgress) =>
                            loadingProgress == null
                                ? child
                                : Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.newsRelease.name,
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Mission: ${state.newsRelease.mission.toUpperCase()}',
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Published in ${DateFormat.yMMMd().format(
                              DateTime.parse(state.newsRelease.publication),
                            )}',
                            style: Theme.of(context).textTheme.caption,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            state.newsRelease.abstract,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    title: Text(
                                      widget.news.name,
                                      softWrap: false,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  body: WebView(
                                    initialUrl: state.newsRelease.url,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text('Read Full Story'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Html(
                            data: state.newsRelease.credits,
                            onLinkTap: (
                              url,
                              renderContext,
                              attributes,
                              element,
                            ) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                    appBar: AppBar(
                                      title: Text('Credits: ${element!.text}'),
                                    ),
                                    body: WebView(
                                      initialUrl: url!.contains('https')
                                          ? url
                                          : url.replaceAll(
                                              'http',
                                              'https',
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: ElevatedButton.icon(
                  onPressed: () => context.read<NewsReleaseBloc>().add(
                        NewsReleaseStarted(id: widget.news.id),
                      ),
                  icon: const Icon(Icons.replay),
                  label: const Text('Retry'),
                ),
              );
            }
          },
        ),
      );
}
