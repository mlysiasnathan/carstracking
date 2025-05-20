import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShowTips extends StatefulWidget {
  const ShowTips({
    super.key,
    this.margin,
    this.padding,
    required this.message,
    this.leadingIcon,
    this.canClose = true,
  });

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final String message;
  final Icon? leadingIcon;
  final bool canClose;

  @override
  State<ShowTips> createState() => _ShowTipsState();
}

class _ShowTipsState extends State<ShowTips> {
  bool _canShow = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return (_canShow)
        ? Container(
            margin: widget.margin,
            padding: widget.padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.primaryColor.withOpacity(0.4),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: widget.leadingIcon ??
                      const Icon(
                        CupertinoIcons.speaker_zzz_fill,
                        color: Colors.white,
                      ),
                ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                      duration: 1500.ms,
                      delay: 300.ms,
                      // color: theme.colorScheme.error.withOpacity(0.4),
                    ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    widget.message,
                    style: theme.textTheme.titleMedium,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.canClose) const SizedBox(width: 15),
                if (widget.canClose)
                  InkWell(
                    onTap: () => setState(() => _canShow = !_canShow),
                    child: const Icon(
                      CupertinoIcons.xmark_circle,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          )
        : const SizedBox();
  }
}
