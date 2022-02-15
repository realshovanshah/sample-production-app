import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_shortener/features/url_shortener/state/state.dart';
import 'package:link_shortener/l10n/l10n.dart';

/// {@template recent_url_list}
/// A [ListView] that displays the recently shortened urls.
/// Reacts to changes in the [UrlShortenerState].
/// {@endtemplate}
class RecentUrlList extends StatelessWidget {
  /// {@macro recent_url_view}
  const RecentUrlList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            l10n.recentUrlTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        BlocBuilder<UrlShortenerCubit, UrlShortenerState>(
          builder: (context, state) {
            if (state.recents.isEmpty) {
              return Center(child: Text(l10n.emptyRecentList));
            }
            return ListView.separated(
              shrinkWrap: true,
              itemCount: state.recents.length,
              itemBuilder: (context, index) {
                return state.recents
                    .map(
                      (url) => RecentUrlTile(
                        originalUrl: url.original,
                        shortUrl: url.shortened,
                      ),
                    )
                    .elementAt(index);
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(thickness: 1),
                );
              },
            );
            // return ListView(shrinkWrap: true);
          },
        ),
      ],
    );
  }
}

/// {@template recent_url_tile}
/// Builds a [ListTile] that displays the original and shortened url.
/// {@endtemplate}
@visibleForTesting
class RecentUrlTile extends StatelessWidget {
  /// {@macro recent_url_tile}
  const RecentUrlTile({
    Key? key,
    required this.originalUrl,
    required this.shortUrl,
  }) : super(key: key);

  /// The original url.
  final String originalUrl;

  /// The shortened url.
  final String shortUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(shortUrl), subtitle: Text(originalUrl));
  }
}
