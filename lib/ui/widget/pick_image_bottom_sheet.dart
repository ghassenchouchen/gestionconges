import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/style/app_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../data/configs/theme.dart';

class PickImageBottomSheet extends StatelessWidget {
  final void Function(ImageSource) onButtonTap;

  const PickImageBottomSheet({Key? key, required this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: AppTheme.commonBoxShadow(context),
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Select Image Source",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.colorScheme.surface,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => onButtonTap(ImageSource.camera),
                child: Text("Camera"),
              ),
              ElevatedButton(
                onPressed: () => onButtonTap(ImageSource.gallery),
                child: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
