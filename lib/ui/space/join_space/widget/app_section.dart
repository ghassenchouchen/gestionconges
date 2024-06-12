import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/data/model/employee/employee.dart';
import 'package:pfeconges/style/app_text_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../style/other/app_button.dart';
import '../../../../app_router.dart';
import 'package:pfeconges/data/di/service_locator.dart';
import 'package:pfeconges/data/provider/user_state.dart';

class AppSection extends StatelessWidget {
  const AppSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserStateNotifier userManager = getIt<UserStateNotifier>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Always centered widgets
        Center(
          child: Column(
            children: [
              SvgPicture.asset(Assets.images.vistoicon),
              const SizedBox(height: 20),
              Text(
                context.l10n.welcome_to_unity_text,
                style: AppTextStyle.style24.copyWith(
                  color: context.colorScheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
        // Conditionally displayed widgets for admin role
        if (userManager.userEmail=='ghassench01@gmail.com') ...[
          Text(
            context.l10n.create_own_space_title,
            style: AppTextStyle.style18.copyWith(
              height: 2.0,
              color: context.colorScheme.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            tag: context.l10n.create_new_space_title,
            onTap: () => context.goNamed(Routes.createSpace),
          ),
        ],
      ],
    );
  }
}
