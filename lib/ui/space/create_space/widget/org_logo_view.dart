import 'package:flutter/material.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/ui/widget/space_logo_view.dart';

class OrgLogoView extends StatelessWidget {
  final void Function()? onButtonTap;

  final String? pickedLogoFile;

  const OrgLogoView({super.key, this.onButtonTap, this.pickedLogoFile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: const Alignment(1.4, 1.4),
        children: [
          SpaceLogoView(size: 75, pickedLogoFile: pickedLogoFile),
       
        ],
      ),
    );
  }
}
