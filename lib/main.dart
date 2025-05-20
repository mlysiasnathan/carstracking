import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './helpers/helpers.dart';
import './providers/providers.dart';
import './routes/atlas_map.dart';
import './routes/screens.dart';
import 'providers/car_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider()..getIn(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => CarProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeProvider.themeMode,
          locale: themeProvider.locale,
          home: const HomeScreen(),
          routes: {
            AuthScreen.routeName: (_) => const AuthScreen(),
            BottomNavBar.routeName: (_) => const BottomNavBar(),
            AtlasMap.routeName: (_) => const AtlasMap(),
          },
        );
      },
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final auth = Provider.of<Auth>(context);

    // AIzaSyAdDcKY-H0Y13e69Xk4U2BzppA3AF9o8iE   GMAP KEY for com.natcoding.carstrack package

    return themeProvider.isInit && auth.isAuth
        ? const BottomNavBar()
        : FutureBuilder(
            future: Future.delayed(const Duration(seconds: 3)),
            builder: (context, splashSnapshot) =>
                splashSnapshot.connectionState == ConnectionState.waiting
                    ? const SplashScreen()
                    : themeProvider.isFirstTime
                        ? const OnBoardingScreen()
                        : !auth.isAuth
                            ? FutureBuilder(
                                future: auth.tryAutologin(),
                                builder: (ctx, authSnapshot) =>
                                    authSnapshot.connectionState ==
                                            ConnectionState.waiting
                                        ? const SplashScreen()
                                        : const AuthScreen(),
                              )
                            : FutureBuilder(
                                future: auth.getUserDetail(),
                                builder: (ctx, authSnapshot) {
                                  if (authSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SplashScreen();
                                  }
                                  if (authSnapshot.hasError) {
                                    Future.delayed(
                                      Duration.zero,
                                      () {
                                        if (context.mounted) {
                                          showToast(
                                            message: const Text(
                                              'Error on Loading user data',
                                            ),
                                            backgroundColor:
                                                theme.colorScheme.error,
                                            context: context,
                                          );
                                        }
                                      },
                                    );
                                    return const AuthScreen();
                                  }
                                  themeProvider.isInit = true;
                                  return const BottomNavBar();
                                },
                              ),
          );
  }
}
