import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghibli_dex/app/modules/movies/presentation/pages/movie_list_page.dart';
import 'package:ghibli_dex/app/modules/movies/presentation/pages/teste_page.dart';
import 'package:ghibli_dex/app/modules/movies/presentation/widgets/selectable_chip.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool showChips = true;
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
      TestePage(scrollController: _scrollController),
      TestePage(scrollController: _scrollController),
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(chipLabels.length, (index) {
                return SelectableChip(
                  label: chipLabels[index],
                  selected: selectedIndex == index,
                  enabled: enabledList[index],
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
