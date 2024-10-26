import 'package:architecture/features/daily_news/domain/usecases/delete_article.dart';
import 'package:architecture/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:architecture/features/daily_news/domain/usecases/save_article.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:architecture/features/daily_news/presentation/pages/home/article_bookmark.dart';
import 'package:architecture/features/daily_news/presentation/widgets/article_widget.dart';
import 'package:architecture/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
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
          return Center(
            child: IconButton(
                onPressed: () {
                  context.read<RemoteArticleBloc>().add(const GetArticles());
                },
                icon: const Icon(Icons.refresh)),
          );
        } else if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return BlocProvider(
                create: (context) => LocalArticleBloc(
                    locator<GetSavedArticleUseCase>(),
                    locator<SaveArticleUseCase>(),
                    locator<DeleteArticleUseCase>()),
                child: ArticleWidget(
                  article: state.articles?[index],
                ),
              );
            },
            itemCount: state.articles!.length,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.indigo.shade50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      onPressed: () {
        Get.to(() => const ArticleBookmark());
      },
      child: Icon(
        Icons.bookmark_add_outlined,
        color: Colors.grey.shade600,
        size: 30,
      ),
    );
  }
}
