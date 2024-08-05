import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../modules/recommendations/presenter/bloc/movies/movies_bloc.dart';
import '../../../../modules/recommendations/presenter/bloc/movies/movies_event.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final str = AppLocalizations.of(context)!;

    return AppBar(
      centerTitle: false,
      title: Text(
        str.movieRecommendation,
        style: theme.textTheme.titleLarge!.copyWith(
          color: theme.scaffoldBackgroundColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => context.read<MoviesBloc>().add(ClearMovie()),
          icon: Icon(
            Icons.add,
            color: theme.scaffoldBackgroundColor,
          ),
        )
      ],
      flexibleSpace: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.3)),
        ],
      ),
    );
  }
}
