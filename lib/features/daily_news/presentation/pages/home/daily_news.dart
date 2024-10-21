import 'package:architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (context, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is RemoteArticlesError) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        } else if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Text('${state.articles?[index].title}');
            },
            itemCount: state.articles!.length,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
