import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../generated/assets.gen.dart';

class CAppBar extends HookConsumerWidget implements PreferredSizeWidget {

  @override
  final Size preferredSize;
  final Widget title;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? subtitle;
  final Color? backgroundColor;

  CAppBar({Key? key,
    Size? preferredSize,
    required this.title,
    this.actions,
    this.leading,
    this.subtitle,
    this.backgroundColor})
      : preferredSize = preferredSize ??
      const Size.fromHeight(
        kToolbarHeight,
      ),
        super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return AppBar(
        backgroundColor: backgroundColor ?? context.colors.tertiary,
        title: title,
        actions: actions,
        elevation: 0,
        leading: Navigator.of(context).canPop()
            ? IconButton(
            onPressed: () {
              Routemaster.of(context).pop();
            },
            icon: Assets.images.icArrowRight.svg()
        )
            : null
    );
  }

}