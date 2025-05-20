import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nrep/routes/atlas_map.dart';

import '../helpers/constants.dart';
import '../widgets/my_end_drawer.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  static const routeName = '/bottom-nav-bar';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PageController _controller = PageController();
  late List<Map<String, Object>> _pages;
  late int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _selectPage(int index) {
    if (index == 1) {
      showToast(
        context: context,
        duration: const Duration(seconds: 10),
        message: const Text("Available in future update"),
      );
    } else if (index == 2) {
      _scaffoldKey.currentState?.openEndDrawer();
    } else if (_selectedIndex != index) {
      _controller.jumpToPage(index);
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      {
        'page': const AtlasMap(),
        'title': 'Atlas',
        'icon': const Icon(CupertinoIcons.map),
        'activeIcon': const Icon(CupertinoIcons.map_fill),
      },
      {
        'page': const AtlasMap(),
        'title': 'Settings',
        'icon': const Icon(CupertinoIcons.gear),
        'activeIcon': const Icon(CupertinoIcons.gear_alt_fill),
      },
    ];
    _selectPage(_selectedIndex);
    final ThemeData theme = Theme.of(context);
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        toolbarHeight: 75,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   appName,
            //   style: theme.textTheme.titleMedium?.copyWith(
            //     color: Colors.black,
            //     fontSize: 20,
            //   ),
            // ),
            Image.asset(
              assetImages[3],
              width: deviceSize.width * 0.35,
              fit: BoxFit.fitWidth,
            ),
            Text(
              'Empowering Uganda with clean cooking knowledge -anytime, -anywhere',
              style: theme.textTheme.labelSmall,
              maxLines: 2,
            ),
          ],
        ),
      ),
      endDrawer: const MyEndDrawer(),
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: _controller,
        onPageChanged: _selectPage,
        children: [_pages[_selectedIndex]['page'] as Widget],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.primaryColor,
        onTap: _selectPage,
        selectedItemColor: theme.colorScheme.surface,
        currentIndex: _selectedIndex,
        selectedFontSize: 14,
        // selectedLabelStyle: const TextStyle(color: Colors.red),
        items: [
          ..._pages.map(
            (screen) => BottomNavigationBarItem(
              icon: screen['icon'] as Icon,
              activeIcon: screen['activeIcon'] as Icon,
              label: screen['title'].toString(),
            ),
          ),
        ],
      ),
    );
  }
}
