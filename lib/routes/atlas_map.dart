import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../helpers/constants.dart';

class AtlasMap extends StatefulWidget {
  const AtlasMap({super.key});

  static const routeName = '/hive-location';

  @override
  State<AtlasMap> createState() => _AtlasMapState();
}

class _AtlasMapState extends State<AtlasMap> {
  late final WebViewController _controller = WebViewController();
  bool _isLoading = true;
  bool _isInit = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    if (!_isInit) {
      _controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(theme.colorScheme.surface)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
                _isInit = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
                _isInit = true;
              });
            },
            onWebResourceError: (WebResourceError error) {
              setState(() {
                _isLoading = false;
                _errorMessage = "Failed to load the Atlas. Please try again.";
                showToast(
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 10),
                  message: Text(
                    error.description.toString(),
                  ),
                  context: context,
                );
              });
            },
          ),
        )
        ..loadRequest(
          Uri.parse(atlasUrl),
        );
    }

    return Container(
      color: theme.colorScheme.surface,
      child: _isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.map,
                  color: theme.primaryColor,
                  size: 50,
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .scale(
                      duration: 600.ms,
                      begin: const Offset(1, 1),
                      end: const Offset(1.5, 1.5),
                      curve: Curves.easeInOut,
                    )
                    .then()
                    .scale(
                      duration: 600.ms,
                      begin: const Offset(1.5, 1.5),
                      end: const Offset(1, 1),
                      curve: Curves.easeInOut,
                    ),
                const SizedBox(height: 100),
                Text(
                  "Loading the Atlas",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.primaryColor,
                  ),
                )
              ],
            )
          : _errorMessage != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.map,
                      color: theme.colorScheme.error,
                      size: 100,
                    ),
                    const SizedBox(height: 100),
                    Text(
                      _errorMessage.toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    )
                  ],
                )
              : WebViewWidget(controller: _controller),
    );
  }
}
