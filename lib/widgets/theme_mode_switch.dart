import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

enum Style {
  mode1,
  mode2,
  mode3,
  mode4,
  mode5,
  mode6,
  mode7,
}

class ThemeModeSwitch extends StatelessWidget {
  const ThemeModeSwitch({
    super.key,
    this.tabs,
    this.styleMode,
    this.showIcon = false,
    this.showLabel = true,
  });

  final List<Tab>? tabs;
  final Style? styleMode;
  final bool showIcon;
  final bool showLabel;

  final List<Tab> defaultTabs = const [
    Tab(
      // text: "System",
      icon: Icon(Icons.link),
      // child: Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Icon(Icons.link),
      //     SizedBox(width: 5),
      //     Text(
      //       "System",
      //       overflow: TextOverflow.ellipsis,
      //       maxLines: 1,
      //     ),
      //   ],
      // ),
    ),
    Tab(
      // text: "Light",
      icon: Icon(CupertinoIcons.sun_max),
      // child: Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Icon(CupertinoIcons.sun_max),
      //     SizedBox(width: 5),
      //     Text(
      //       "Light",
      //       maxLines: 1,
      //       overflow: TextOverflow.ellipsis,
      //     ),
      //   ],
      // ),
    ),
    Tab(
      // text: "Dark",
      icon: Icon(CupertinoIcons.moon_fill),
      // child: Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Icon(CupertinoIcons.moon_stars_fill),
      //     SizedBox(width: 5),
      //     Text(
      //       "Dark",
      //       maxLines: 1,
      //       overflow: TextOverflow.ellipsis,
      //     ),
      //   ],
      // ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Style style = styleMode ?? Style.mode7;
    return DefaultTabController(
      initialIndex: themeProvider.themeMode.index,
      length: tabs?.length ?? defaultTabs.length,
      child: Column(
        children: [
          if (style == Style.mode1)
            TabBar(
              indicatorWeight: 5,
              splashBorderRadius: BorderRadius.circular(30),
              dividerHeight: 0,
              unselectedLabelStyle: theme.textTheme.labelSmall
                  ?.copyWith(fontSize: 13, color: Colors.grey),
              labelStyle: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
              onTap: (index) {
                if (index == ThemeMode.system.index) {
                  themeProvider.followTheSystem();
                } else if (index == ThemeMode.light.index) {
                  themeProvider.setLightTheme();
                } else if (index == ThemeMode.dark.index) {
                  themeProvider.setDarkTheme();
                }
              },
              tabs: tabs ?? defaultTabs,
            ),
          if (style == Style.mode2)
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 5,
              splashBorderRadius: BorderRadius.circular(30),
              dividerHeight: 0,
              unselectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
                fontSize: 13,
                color: Colors.grey,
              ),
              labelStyle: theme.textTheme.labelSmall?.copyWith(
                fontSize: 16,
              ),
              onTap: (index) {
                if (index == ThemeMode.system.index) {
                  themeProvider.followTheSystem();
                } else if (index == ThemeMode.light.index) {
                  themeProvider.setLightTheme();
                } else if (index == ThemeMode.dark.index) {
                  themeProvider.setDarkTheme();
                }
              },
              tabs: tabs ?? defaultTabs,
            ),
          if (style == Style.mode3)
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 5,
              indicator: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(30),
              ),
              splashBorderRadius: BorderRadius.circular(30),
              dividerHeight: 0,
              unselectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
                fontSize: 13,
                color: Colors.grey,
              ),
              labelStyle: theme.textTheme.labelSmall?.copyWith(
                fontSize: 16,
              ),
              onTap: (index) {
                if (index == ThemeMode.system.index) {
                  themeProvider.followTheSystem();
                } else if (index == ThemeMode.light.index) {
                  themeProvider.setLightTheme();
                } else if (index == ThemeMode.dark.index) {
                  themeProvider.setDarkTheme();
                }
              },
              tabs: tabs ?? defaultTabs,
            ),
          if (style == Style.mode4)
            Container(
              height: kToolbarHeight,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 5,
                indicator: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                splashBorderRadius: BorderRadius.circular(30),
                dividerHeight: 0,
                unselectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 13,
                  color: theme.primaryColor,
                ),
                labelStyle: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
                onTap: (index) {
                  if (index == ThemeMode.system.index) {
                    themeProvider.followTheSystem();
                  } else if (index == ThemeMode.light.index) {
                    themeProvider.setLightTheme();
                  } else if (index == ThemeMode.dark.index) {
                    themeProvider.setDarkTheme();
                  }
                },
                tabs: tabs ?? defaultTabs,
              ),
            ),
          if (style == Style.mode5)
            Container(
              height: kToolbarHeight,
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.primaryColor,
                  width: 2,
                ),
                color: theme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 5,
                indicator: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                splashBorderRadius: BorderRadius.circular(30),
                dividerHeight: 0,
                unselectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 13,
                  color: theme.primaryColor,
                ),
                labelStyle: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
                onTap: (index) {
                  if (index == ThemeMode.system.index) {
                    themeProvider.followTheSystem();
                  } else if (index == ThemeMode.light.index) {
                    themeProvider.setLightTheme();
                  } else if (index == ThemeMode.dark.index) {
                    themeProvider.setDarkTheme();
                  }
                },
                tabs: tabs ?? defaultTabs,
              ),
            ),
          if (style == Style.mode6)
            Container(
              height: kToolbarHeight - 8,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 5,
                indicator: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(15),
                ),
                splashBorderRadius: BorderRadius.circular(30),
                dividerHeight: 0,
                unselectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 13,
                  color: theme.primaryColor,
                ),
                labelStyle: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 18,
                  color: Colors.white,
                ),
                onTap: (index) {
                  if (index == ThemeMode.system.index) {
                    themeProvider.followTheSystem();
                  } else if (index == ThemeMode.light.index) {
                    themeProvider.setLightTheme();
                  } else if (index == ThemeMode.dark.index) {
                    themeProvider.setDarkTheme();
                  }
                },
                tabs: tabs ?? defaultTabs,
              ),
            ),
          if (style == Style.mode7)
            Container(
              height: kToolbarHeight,
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.primaryColor,
                  width: 2,
                ),
                color: theme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 5,
                indicator: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(11),
                ),
                splashBorderRadius: BorderRadius.circular(11),
                dividerHeight: 0,
                unselectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 13,
                  color: theme.primaryColor,
                ),
                labelStyle: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
                onTap: (index) {
                  if (index == ThemeMode.system.index) {
                    themeProvider.followTheSystem();
                  } else if (index == ThemeMode.light.index) {
                    themeProvider.setLightTheme();
                  } else if (index == ThemeMode.dark.index) {
                    themeProvider.setDarkTheme();
                  }
                },
                tabs: tabs ?? defaultTabs,
              ),
            ),
        ],
      ),
    );
  }
}
