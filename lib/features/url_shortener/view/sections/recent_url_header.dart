import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_shortener/app/components/components.dart';
import 'package:link_shortener/features/url_shortener/state/url_shortener_cubit.dart';
import 'package:link_shortener/l10n/l10n.dart';

/// {@template recent_url_header}
/// The header of the RecentUrlPage that displays the title and
/// provides a button to sort the recent urls.
/// {@endtemplate}
class RecentUrlHeader extends StatefulWidget {
  /// {@macro recent_url_header}
  const RecentUrlHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentUrlHeader> createState() => _RecentUrlHeaderState();
}

class _RecentUrlHeaderState extends State<RecentUrlHeader> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        Text(
          l10n.recentUrlTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
        const Spacer(),
        Text('${l10n.sort}: '),
        SortActionButton(
          onSort: () => context.read<UrlShortenerCubit>().recentUrlsSorted(),
        ),
      ],
    );
  }
}
