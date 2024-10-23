import 'package:architecture/features/daily_news/domain/entities/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;

  ArticleWidget({
    super.key,
    this.article,
  });

  WebViewController webViewController = WebViewController();
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            if (article?.url != null) {
              return Container(
                padding: const EdgeInsets.only(top: 60),
                child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(30)),
                    child: WebViewWidget(
                      gestureRecognizers: gestureRecognizers,
                      controller: webViewController
                        ..setJavaScriptMode(JavaScriptMode.disabled)
                        ..loadRequest(Uri.parse(article!.url!)),
                    )),
              );
            } else {
              return const Center(
                child: Text('Error!'),
              );
            }
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.white),
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            _buildImage(context, article?.urlToImage),
            _buildTitleAndDescription(context, article?.title,
                article?.description, article?.publishedAt)
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, String? imageSrc) {
    double? width = MediaQuery.of(context).size.width / 3;
    double? height = MediaQuery.of(context).size.height;
    if (imageSrc != null && imageSrc.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: article!.urlToImage!,
        imageBuilder: (context, imageProvider) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
        placeholder: (context, url) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
            child: const CupertinoActivityIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
            child: const Icon(Icons.error_outline),
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
          child: const Icon(Icons.error_outline),
        ),
      );
    }
  }

  Widget _buildTitleAndDescription(BuildContext context, String? title,
      String? description, String? publishedAt) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              description ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                const Icon(
                  Icons.timeline_rounded,
                  color: Colors.black54,
                  size: 20,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  publishedAt ?? "",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
