import 'package:flutter/material.dart';
import 'package:rick_and_morty2/api/api_character.dart';
import 'package:rick_and_morty2/api/api_service.dart';
import 'package:rick_and_morty2/constants/app_colors.dart';
import 'package:rick_and_morty2/screens/character_list_screen.dart';
import 'package:rick_and_morty2/screens/eppisode_screen.dart';
import 'package:rick_and_morty2/screens/save_screen.dart';
import 'package:rick_and_morty2/screens/settings_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final ScrollController controller = ScrollController();

  List<Character> displayed = [];
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = false;
  bool isGrid = false;
  int _index = 0;

  List<Widget> get _pages => [
    CharactersBody(
      displayed: displayed,
      isGrid: isGrid,
      isLoading: isLoading,
      controller: controller,
      toggleView: () => setState(() => isGrid = !isGrid),
    ),
    SaveScreen(),
    EppisodeScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _loadPage();

    controller.addListener(() {
      if (controller.position.pixels >=
              controller.position.maxScrollExtent - 300 &&
          !isLoading &&
          currentPage < totalPages) {
        _loadPage();
      }
    });
  }

  Future<void> _loadPage() async {
    setState(() => isLoading = true);
    try {
      final resp = await fetchCharacterPage(currentPage);
      setState(() {
        totalPages = resp.info.pages;
        displayed.addAll(resp.results);
        currentPage++;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _navigateBottomBar(int index) {
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.appBarColorDark
            : AppColors.appBarColorLight,
        elevation: 0,
        title: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.poiskColorDark
                : AppColors.poiskColorLight,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Icon(
                Icons.search,
                color: isDark
                    ? AppColors.bNBUnselectedIColorDark
                    : AppColors.bNBUnselectedIColorLight,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: isDark
                              ? AppColors.nameDescriptionEpisodeColorDark
                              : AppColors.nameDescriptionEpisodeColorLight,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Найти персонажа',
                          hintStyle: TextStyle(
                            color: isDark
                                ? AppColors.speciesGenderDetailColorDark
                                : AppColors.speciesGenderDetailColorLight,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: const VerticalDivider(
                  width: 24,
                  color: Color(0xaa5B6975),
                  thickness: 1,
                ),
              ),
              Icon(
                Icons.filter_alt,
                color: isDark
                    ? AppColors.bNBUnselectedIColorDark
                    : AppColors.bNBUnselectedIColorLight,
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: _navigateBottomBar,
        backgroundColor: isDark
            ? AppColors.nBNColorDark
            : AppColors.nBNColorLight,
        selectedItemColor: isDark
            ? AppColors.bNBSelectedIColorDark
            : AppColors.bNBSelectedIColorLight,
        unselectedItemColor: isDark
            ? AppColors.bNBUnselectedIColorDark
            : AppColors.bNBUnselectedIColorLight,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/ghost_.png'), size: 25),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.heart_broken, size: 25),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/episode_icon_.png'),
              size: 25,
            ),
            label: 'Episodes',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/settings_.png'), size: 25),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
