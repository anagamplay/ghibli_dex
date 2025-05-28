import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghibli_dex/app/modules/movies/presentation/pages/movie_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body: MovieListPage(),
    );
  }
}
