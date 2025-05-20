import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/constants.dart';
import '../providers/providers.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  final PageController _controller = PageController();
  final List<Map<String, dynamic>> demoData = [
    {
      'image': onBoardingImages[1],
      'title': 'Empowering Communities with Modern Cooking Solutions',
      'desc':
          'Discover how Fumba Hub is transforming cooking practices by providing sustainable energy solutions to households across Africa.'
    },
    {
      'image': onBoardingImages[0],
      'title': 'Access Real-Time Energy Data',
      'desc':
          'Explore up-to-date statistics and trends on electricity and cooking fuel access to make informed decisions for your community.'
    },
    {
      'image': onBoardingImages[0],
      'title': 'Join the Clean Cooking Movement',
      'desc':
          'Be part of a growing initiative aimed at reducing reliance on traditional biomass fuels and promoting cleaner, healthier cooking methods'
    },
  ];

  @override
  Widget build(BuildContext context) {
    void getStarted() {
      Provider.of<ThemeProvider>(context, listen: false).getStarted();
    }

    final ThemeData theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: demoData.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(demoData[index]['image']),
                      ),
                      Text(
                        demoData[index]['title'],
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: deviceSize.width * 0.07,
                          fontWeight: FontWeight.w900,
                          overflow: TextOverflow.ellipsis,
                          // color: theme.primaryColor,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        demoData[index]['desc'],
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: deviceSize.width * 0.04,
                          overflow: TextOverflow.ellipsis,
                          // color: theme.primaryColor,
                        ),
                        maxLines: 4,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: _currentPage == demoData.length - 1
                        ? null
                        : TextButton(
                            onPressed: () =>
                                _controller.jumpToPage(demoData.length),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      demoData.length,
                      (index) => AnimatedContainer(
                        height: 6,
                        width: _currentPage == index ? 20 : 6,
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? theme.primaryColor
                              : theme.primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: _currentPage == demoData.length - 1
                        ? Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextButton(
                              onPressed: getStarted,
                              child: Text(
                                'GET STARTED',
                                style: TextStyle(
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : TextButton(
                            onPressed: () => _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
