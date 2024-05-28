import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/data/model/employee/employee.dart';
import 'package:pfeconges/style/app_text_style.dart';
class ToggleButton extends StatelessWidget {
  final Role role;
  final Function(Role role) onRoleChange;

  const ToggleButton(
      {super.key, required this.onRoleChange, required this.role});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    // Calculate width based on the number of roles (now only 2)
    final double width =
        MediaQuery.of(context).size.width / _toggleButtonAlignment.length;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(4),
        height: 60.0,
        decoration: BoxDecoration(
          color: context.colorScheme.containerNormal,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Stack(
          children: [
            // Animated Indicator
            AnimatedAlign(
              alignment:
                  Alignment(_toggleButtonAlignment[role] ?? 0, 0), // Default to 0
              curve: Curves.ease,
              duration: const Duration(milliseconds: 300),
              child: Container(
                
                width: width,
                height: 48,
                decoration: BoxDecoration(
                  color: context.colorScheme.tertiary,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),

            // Toggle Buttons with Text (Only Employee and HR)
            Row(
              children: _toggleButtonAlignment.entries.map(
                (roleTypeAlignment) => Expanded(
                  child: InkWell(
                    onTap: () => onRoleChange(roleTypeAlignment.key),
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      child: Text(
                        localization
                            .user_detail_role_type(roleTypeAlignment.key.name),
                        style: AppTextStyle.style16.copyWith(
                          color: context.colorScheme.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// Update the alignment map to exclude admin
final Map<Role, double> _toggleButtonAlignment = {
  Role.employee: -1,
  Role.hr: 1,
};