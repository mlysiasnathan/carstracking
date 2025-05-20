import 'package:flutter/material.dart';

class SettingItem extends StatefulWidget {
  const SettingItem({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.children,
    this.subtitle,
  });

  final Text? title;
  final Widget? subtitle;
  final Icon leadingIcon;
  final List<Widget>? children;

  @override
  State<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  var _expanded = false;
  var _showChild = false;
  final _duration = 400;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: theme.primaryColor.withOpacity(0.4),
          width: 1,
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(2),
            onTap: () {
              setState(() => _expanded = !_expanded);
              Future.delayed(
                Duration(milliseconds: _duration + 2),
                () => setState(() => _showChild = !_showChild),
              );
            },
            child: ListTile(
              minTileHeight: 70,
              leading: widget.leadingIcon,
              title: widget.title,
              subtitle: widget.subtitle,
              trailing:
                  Icon(_expanded ? Icons.expand_more : Icons.chevron_right),
            ),
          ),
          // if (_expanded)
          AnimatedContainer(
            duration: Duration(milliseconds: _duration),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            height: _expanded ? 110 : 0,
            child: _showChild && _expanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [...?widget.children],
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
