import 'package:blogclub/article.dart';
import 'package:blogclub/gen/assets.gen.dart';
import 'package:blogclub/gen/fonts.gen.dart';
import 'package:blogclub/home.dart';
import 'package:blogclub/profile.dart';
import 'package:blogclub/searchscreen.dart';
import 'package:blogclub/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryTextColor = Color(0xff0D253C);
    const secondaryTextColor = Color(0xff2D4379);
    const primaryColor = Color(0xff376AED);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          onPrimary: Colors.white,
          onSurface: primaryTextColor,
          onBackground: primaryTextColor,
          background: Color(0xfffbfcff),
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: primaryTextColor,
          elevation: 0,
          titleSpacing: 50,
        ),
        snackBarTheme: const SnackBarThemeData(backgroundColor: primaryColor),
        textTheme: const TextTheme(
          subtitle1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w200,
            fontFamily: FontFamily.avenir,
            color: secondaryTextColor,
          ),
          subtitle2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.avenir,
            color: primaryTextColor,
          ),
          headline5: TextStyle(
            fontFamily: FontFamily.avenir,
            fontWeight: FontWeight.w700,
            color: primaryTextColor,
          ),
          headline6: TextStyle(
            fontFamily: FontFamily.avenir,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: primaryTextColor,
          ),
          caption: TextStyle(
            fontFamily: FontFamily.avenir,
            color: secondaryTextColor,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontFamily: FontFamily.avenir,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: primaryColor,
              ),
            ),
          ),
        ),
      ),
      // home: Stack(
      //   children: [
      //     const Positioned.fill(child: HomeScreen()),
      //     Positioned(left: 0, right: 0, bottom: 0, child: _BottomNavigation())
      //   ],
      // ),
      home: const SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

const int homeIndex = 0;
const int articleIndex = 1;
const int searchIndex = 2;
const int menuIndex = 3;
const double bottomNavigationHeight = 65;

class _MainScreenState extends State<MainScreen> {
  int selectedTabIndex = homeIndex;

  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _articleKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _menuKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    articleIndex: _articleKey,
    searchIndex: _searchKey,
    menuIndex: _menuKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedTabIndex]!.currentState!;

    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedTabIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              bottom: bottomNavigationHeight,
              child: IndexedStack(
                index: selectedTabIndex,
                children: [
                  _navigator(_homeKey, homeIndex, const HomeScreen()),
                  _navigator(_articleKey, articleIndex, const ArticleScreen()),
                  _navigator(_searchKey, searchIndex, const SearchScreen()),
                  _navigator(_menuKey, menuIndex, const ProfileScreen()),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _BottomNavigation(
                onTap: (int index) {
                  setState(() {
                    _history.remove(selectedTabIndex);
                    _history.add(selectedTabIndex);
                    selectedTabIndex = index;
                  });
                },
                selectedTabIndex: selectedTabIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedTabIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    // **** This widget causes to draw objects on screen when needed(when we are in that screen)
                    offstage: selectedTabIndex != index,
                    child: child)),
          );
  }
}

class _BottomNavigation extends StatelessWidget {
  final Function(int index) onTap;
  final int selectedTabIndex;

  const _BottomNavigation(
      {Key? key, required this.onTap, required this.selectedTabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: bottomNavigationHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff9b8487).withOpacity(0.3),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _BottomNavigationItem(
                    iconFileName: 'Home.png',
                    activeIconFileName: 'HomeActive.png',
                    title: 'Home',
                    onTap: () {
                      onTap(homeIndex);
                    },
                    isActive: selectedTabIndex == homeIndex,
                  ),
                  _BottomNavigationItem(
                    iconFileName: 'Articles.png',
                    activeIconFileName: 'ArticlesActive.png',
                    title: 'Articles',
                    onTap: () {
                      onTap(articleIndex);
                    },
                    isActive: selectedTabIndex == articleIndex,
                  ),
                  Expanded(
                      child:
                          Container()), // For creating space between Articles & Search icons
                  _BottomNavigationItem(
                    iconFileName: 'Search.png',
                    activeIconFileName: 'SearchActive.png',
                    title: 'Search',
                    onTap: () {
                      onTap(searchIndex);
                    },
                    isActive: selectedTabIndex == searchIndex,
                  ),
                  _BottomNavigationItem(
                    iconFileName: 'Menu.png',
                    activeIconFileName: 'MenuActive.png',
                    title: 'Menu',
                    onTap: () {
                      onTap(menuIndex);
                    },
                    isActive: selectedTabIndex == menuIndex,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 2 - 26,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xff376AED),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  width: 4,
                  color: Colors.white,
                ),
              ),
              child: Assets.img.icons.plus.image(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  final String iconFileName;
  final String activeIconFileName;
  final String title;
  final Function() onTap;
  final bool isActive;

  const _BottomNavigationItem(
      {Key? key,
      required this.iconFileName,
      required this.activeIconFileName,
      required this.title,
      required this.onTap,
      required this.isActive})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/icons/${isActive ? activeIconFileName : iconFileName}',
              width: 24,
              height: 24,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              title,
              style: themeData.textTheme.caption!.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: isActive
                      ? themeData.colorScheme.primary
                      : const Color(0xff7B8BB2)),
            ),
          ],
        ),
      ),
    );
  }
}
