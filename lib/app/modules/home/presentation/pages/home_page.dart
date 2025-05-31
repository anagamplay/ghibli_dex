import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../movies/data/services/favorite_movie_service.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../../movies/presentation/pages/favorites_pages.dart';
import '../../../movies/presentation/pages/movie_list_by_category_page.dart';
import '../../../movies/presentation/pages/movie_list_page.dart';
import '../widgets/selectable_chip.dart';

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

  late final ScrollController _allController;
  late final ScrollController _byCategoryController;
  late final ScrollController _favoritesController;

  final List<String> chipLabels = ['All', 'By Category', 'Favorites'];
  final List<bool> enabledList = [true, true, false];

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    _allController = ScrollController();
    _byCategoryController = ScrollController();
    _favoritesController = ScrollController();

    _allController.addListener(() => _handleScroll(_allController));
    _byCategoryController
        .addListener(() => _handleScroll(_byCategoryController));
    _favoritesController.addListener(() => _handleScroll(_favoritesController));

    pages = [
      MovieListPage(scrollController: _allController),
      MovieListByCategoryPage(scrollController: _byCategoryController),
      FavoritesPage(scrollController: _favoritesController),
    ];

    favoritesNotifier = FavoriteMovieService.favoritesNotifier;
    _initFavoritesState();
  }

  @override
  void dispose() {
    _allController.dispose();
    _byCategoryController.dispose();
    _favoritesController.dispose();
    super.dispose();
  }

  void _handleScroll(ScrollController controller) {
    if (selectedIndex != 2) {
      if (controller.position.userScrollDirection == ScrollDirection.reverse &&
          showChips) {
        setState(() => showChips = false);
      } else if (controller.position.userScrollDirection ==
              ScrollDirection.forward &&
          !showChips) {
        setState(() => showChips = true);
      }
    } else {
      if (!showChips) {
        setState(() => showChips = true);
      }
    }
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
          child: IndexedStack(
            index: selectedIndex,
            children: pages,
          ),
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
