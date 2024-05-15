import 'package:flutter/material.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/data/core/extensions/string_extension.dart';
import 'package:pfeconges/data/core/extensions/widget_extension.dart';
import 'package:pfeconges/style/app_text_style.dart';
import 'package:pfeconges/ui/widget/user_profile_image.dart';
import 'package:pfeconges/ui/widget/widget_validation.dart';
import '../../data/configs/space_constant.dart';
import '../../data/model/employee/employee.dart';

class EmployeeCard extends StatelessWidget {
  final void Function()? onTap;
  final Employee employee;

  const EmployeeCard({super.key, this.onTap, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: primaryVerticalSpacing, vertical: primaryHalfSpacing),
      child: Row(
        children: [
          ImageProfile(
            imageUrl: employee.imageUrl,
            radius: 25,
          ),
          const SizedBox(
            width: primaryHorizontalSpacing,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(employee.name,
                    style: employee.status == EmployeeStatus.inactive
                        ? AppTextStyle.style18
                            .copyWith(color: context.colorScheme.textSecondary)
                        : AppTextStyle.style18.copyWith(
                            color: context.colorScheme.textPrimary,
                            height: 1.5),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1),
                ValidateWidget(
                  isValid: employee.designation.isNotNullOrEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(employee.designation ?? "",
                        style: AppTextStyle.style14
                            .copyWith(color: context.colorScheme.textSecondary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ).onTapGesture(() {
      onTap?.call();
    });
  }
}
