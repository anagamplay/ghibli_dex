import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghibli_dex/app/modules/movies/presentation/widgets/selectable_chip.dart';

import '../../data/services/favorite_movie_service.dart';
import '../../domain/entities/movie.dart';
import 'favorites_pages.dart';
import 'movie_list_by_category_page.dart';
import 'movie_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ValueNotifier<List<Movie>> favoritesNotifier;

  int selectedIndex = 0;
  bool showChips = true;
  bool hasFavorites = false;
  late ScrollController _scrollController;

  final List<String> chipLabels = ['All', 'By Category', 'Favorites'];
  final List<bool> enabledList = [true, true, false];

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          showChips) {
        setState(() => showChips = false);
      } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          !showChips) {
        setState(() => showChips = true);
      }
    });

    pages = [
      MovieListPage(scrollController: _scrollController),
      MovieListByCategoryPage(scrollController: _scrollController),
      FavoritesPage(scrollController: _scrollController),
    ];

    favoritesNotifier = FavoriteMovieService.favoritesNotifier;
    _initFavoritesState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initFavoritesState() async {
    final favorites = await FavoriteMovieService.getFavorites();
    favoritesNotifier.value = List.from(favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/logo.svg',
          height: 40,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Column _body() {
    return Column(
      children: [
        _chipList(),
        Expanded(
          child: pages[selectedIndex],
        ),
      ],
    );
  }

  AnimatedContainer _chipList() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: showChips ? 50 : 0,
      child: ClipRect(
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: showChips ? Offset.zero : const Offset(0, -1),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            child: ValueListenableBuilder<List<Movie>>(
              valueListenable: favoritesNotifier,
              builder: (context, favorites, _) {
                final hasFavorites = favorites.isNotEmpty;
                final enabledList = [true, true, hasFavorites];

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(chipLabels.length, (index) {
                    return SelectableChip(
                      label: chipLabels[index],
                      selected: selectedIndex == index,
                      enabled: enabledList[index],
                      onTap: () => setState(() => selectedIndex = index),
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
