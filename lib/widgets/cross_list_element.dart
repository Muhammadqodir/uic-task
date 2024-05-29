import 'dart:io';
import 'package:audiobook/widgets/cupertino_ink.dart';
import 'package:audiobook/widgets/ontap_scale.dart';
import 'package:flutter/material.dart';

class CrossListElement extends StatelessWidget {
  const CrossListElement({
    Key? key,
    required this.onPressed,
    required this.child,
    this.enabled = true,
  }) : super(key: key);

  final Widget child;
  final bool enabled;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Platform.isIOS
            ? CupertinoInkWell(
                onPressed: onPressed,
                child: OnTapScaleAndFade(
                  onTap: onPressed!,
                  lowerBound: 0.98,
                  child: Opacity(
                    opacity: enabled ? 1 : 0.6,
                    child: child,
                  ),
                ),
              )
            : InkWell(
                onTap: onPressed,
                child: OnTapScaleAndFade(
                  lowerBound: 0.98,
                  onTap: onPressed!,
                  child: Opacity(
                    opacity: enabled ? 1 : 0.6,
                    child: child,
                  ),
                ),
              ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
          ),
          height: 0.6,
        )
      ],
    );
  }
}
