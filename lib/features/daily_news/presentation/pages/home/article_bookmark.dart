import 'package:architecture/core/constants/constants.dart';
import 'package:architecture/features/daily_news/domain/usecases/delete_article.dart';
import 'package:architecture/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:architecture/features/daily_news/domain/usecases/save_article.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:architecture/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:architecture/features/daily_news/presentation/widgets/article_widget.dart';
import 'package:architecture/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class ArticleBookmark extends StatelessWidget {
  const ArticleBookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalArticleBloc(locator<GetSavedArticleUseCase>(),
          locator<SaveArticleUseCase>(), locator<DeleteArticleUseCase>())
        ..add(const GetSavedArticles()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        'Saved Articles',
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.grey.shade500,
          size: 25,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
      builder: (context, state) {
        if (state is LocalArticleLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LocalArticleDone) {
          if (state.articles?.isEmpty ?? false) {
            return const Center(
              child: Text("Data does not exist!"),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ArticleWidget(
                  article: state.articles?[index],
                  screenType: ScrType.bookmark,
                );
              },
              itemCount: state.articles?.length,
            );
          }
        } else {
          return const Center(
            child: Text("Error!"),
          );
        }
      },
    );
  }
}
