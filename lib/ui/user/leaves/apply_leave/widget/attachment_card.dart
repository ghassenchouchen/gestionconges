/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/data/model/leave/leave.dart';
import 'package:pfeconges/style/app_text_style.dart';
import 'package:pfeconges/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart';
import 'package:pfeconges/ui/user/leaves/apply_leave/bloc/apply_leave_event.dart';
import 'package:pfeconges/ui/user/leaves/apply_leave/bloc/apply_leave_state.dart';

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      context.read<ApplyLeaveBloc>().add(ApplyLeaveAddAttachmentEvent(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
      buildWhen: (previous, current) => previous.attachment != current.attachment,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => _pickImage(context),
              child: Text("Ajouter Document Justificatif"),
            ),
            if (state.attachment != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Fichier sélectionné: ${state.attachment!.name}",
                  style: TextStyle(fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
*/