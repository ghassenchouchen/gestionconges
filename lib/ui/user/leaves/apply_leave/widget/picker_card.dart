import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pfeconges/data/configs/space_constant.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/gen/assets.gen.dart';
import 'package:pfeconges/style/app_text_style.dart';
class DatePickerCard extends StatelessWidget {
  final Function() onPress;
  final String title;
  final DateTime date;

  const DatePickerCard({
    super.key,
    required this.onPress,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(primaryHalfSpacing),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: context.colorScheme.primary))),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.style18
                    .copyWith(color: context.colorScheme.textSecondary),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.images.calendar,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(localization.date_format_yMMMd(date),
                      style: AppTextStyle.style18.copyWith(
                          color: context.colorScheme.textPrimary,
                          textBaseline: TextBaseline.alphabetic)),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}