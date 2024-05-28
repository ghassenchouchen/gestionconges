import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/data/core/extensions/string_extension.dart';
import 'package:pfeconges/data/di/service_locator.dart';
import 'package:pfeconges/data/model/employee/employee.dart';
import 'package:pfeconges/style/app_bar.dart';
import 'package:pfeconges/style/app_text_style.dart';
import 'package:pfeconges/style/other/app_button.dart';
import 'package:pfeconges/ui/widget/circular_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:pfeconges/ui/widget/error_snack_bar.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../style/app_page.dart';
import '../../../widget/employee_details_textfield.dart';
import 'bloc/invite_member_bloc.dart';
import 'bloc/invite_member_event.dart';
import 'bloc/invite_member_state.dart';

class InviteMemberPage extends StatelessWidget {
  const InviteMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InviteMemberBloc>(
      create: (_) => getIt.get<InviteMemberBloc>(),
      child: const SearchMemberScreen(),
    );
  }
}

class SearchMemberScreen extends StatefulWidget {
  const SearchMemberScreen({super.key});

  @override
  State<SearchMemberScreen> createState() => _SearchMemberScreenState();
}

class _SearchMemberScreenState extends State<SearchMemberScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return AppPage(
      appBar:AppBar( backgroundColor: AppBarStyles.appBarBackgroundColor,
      iconTheme: IconThemeData(color: AppBarStyles.appBarIconColor),
        centerTitle: true,),
        
      backGroundColor: context.colorScheme.surface,
      titleWidget: Text(locale.admin_home_invite_member_appbar_tag,style: AppBarStyles.appBarTextStyle),
      body: BlocConsumer<InviteMemberBloc, InviteMemberState>(
        listenWhen: (previous, current) =>
            current.status == Status.success || current.error.isNotNullOrEmpty,
        listener: (context, state) {
          if (state.error.isNotNullOrEmpty) {
            showSnackBar(context: context, error: state.error);
          } else if (state.status == Status.success) {
            context.pop();
          }
        },
        buildWhen: (previous, current) =>
            previous.email != current.email ||
            previous.status != current.status,
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const AppCircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                BlocBuilder<InviteMemberBloc, InviteMemberState>(
                    builder: (context, state) {
                  return FieldEntry(
                    hintText: locale.admin_home_invite_member_hint_text,
                    errorText: state.emailError
                        ? locale.admin_home_invite_member_error_email
                        : null,
                    onChanged: (String query) => context
                        .read<InviteMemberBloc>()
                        .add(AddEmailEvent(query)),
                  );
                }),
                  const SizedBox(height: 10),
                 BlocBuilder<InviteMemberBloc, InviteMemberState>(
                  buildWhen: (previous, current) =>
                      previous.role != current.role,
                  builder: (context, state) => ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<Role>(
                      dropdownColor: context.colorScheme.surface,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      items: Role.values.map((role) {
                        return DropdownMenuItem<Role>(
                          value: role,
                          child: Text(
                            context.l10n.user_add_role_type(
                                role.value.toString()),
                            style: AppTextStyle.style18
                                .copyWith(color: context.colorScheme.textPrimary),
                          ),
                        );
                      }).toList(),
                      value: state.role,
                      onChanged: (Role? role) {
                        context.read<InviteMemberBloc>().add(
                            UpdateRoleEvent(role: role));
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                AppButton(
                  tag: context.l10n.invite_tag,
                  onTap: () =>
                      context.read<InviteMemberBloc>().add(InviteMemberEvent()),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
