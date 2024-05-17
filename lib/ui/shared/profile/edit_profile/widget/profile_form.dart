import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/style/app_text_style.dart';
import 'package:pfeconges/ui/widget/pick_profile_image/pick_user_profile_image.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../widget/date_time_picker.dart';
import '../../../../widget/employee_details_textfield.dart';
import '../bloc/employee_edit_profile_bloc.dart';
import '../bloc/employee_edit_profile_event.dart';
import '../bloc/employee_edit_profile_state.dart';

class ProfileForm extends StatelessWidget {
  final String? profileImageURL;
  final TextEditingController nameController;
  final TextEditingController designationController;
  final TextEditingController phoneNumberController;
  final TextEditingController addressController;
  final TextEditingController levelController;

  const ProfileForm({
    super.key,
    required this.profileImageURL,
    required this.nameController,
    required this.designationController,
    required this.phoneNumberController,
    required this.addressController,
    required this.levelController,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final bloc = context.read<EmployeeEditProfileBloc>();
    return ListView(
      padding: const EdgeInsets.all(primaryHorizontalSpacing).copyWith(top: 30),
      children: [
        ProfileImagePicker(
          imageURl: profileImageURL,
          onPickImageChange: (String image) => context
              .read<EmployeeEditProfileBloc>()
              .add(ChangeImageEvent(image)),
        ),
        FieldTitle(title: localization.employee_name_tag),
        BlocBuilder<EmployeeEditProfileBloc, EmployeeEditProfileState>(
          buildWhen: (previous, current) =>
              previous.nameError != current.nameError,
          builder: (context, state) => FieldEntry(
            controller: nameController,
            onChanged: (value) =>
                bloc.add(EditProfileNameChangedEvent(name: value)),
            errorText: state.nameError
                ? localization.admin_home_add_member_error_name
                : null,
            hintText: localization.admin_home_add_member_name_hint_text,
          ),
        ),
        FieldTitle(title: localization.employee_designation_tag),
        FieldEntry(
          controller: designationController,
          hintText: localization.admin_home_add_member_designation_hint_text,
        ),
        FieldTitle(title: localization.employee_level_tag),
        FieldEntry(
          controller: levelController,
          hintText: localization.admin_home_add_member_level_hint_text,
        ),
        
      
        FieldTitle(title: localization.employee_mobile_tag),
        BlocBuilder<EmployeeEditProfileBloc, EmployeeEditProfileState>(
            buildWhen: (previous, current) =>
                previous.numberError != current.numberError,
            builder: (context, state) {
              return FieldEntry(
                maxLength: 8,
                errorText: state.numberError
                    ? context.l10n.invalid_mobile_number_error
                    : null,
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
                hintText:
                    localization.admin_home_add_member_mobile_number_hint_text,
                onChanged: (value) =>
                    bloc.add(EditProfileNumberChangedEvent(number: value)),
              );
            }),
        
      ],
    );
  }
}


