import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:pfeconges/data/model/leave/leave.dart';

import '../../../../../data/core/utils/bloc_status.dart';

class ApplyLeaveState extends Equatable {
  final Status leaveRequestStatus;
  final LeaveType leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final Map<DateTime, LeaveDayDuration> selectedDates;
  final double totalLeaveDays;
  final String reason;
  final bool showTextFieldError;
  final String? error;
  final String? leaveId;
  final File? attachment;
  final Map<LeaveType, int> availableLeaveDays;


  const ApplyLeaveState({
    this.leaveId,
    this.leaveRequestStatus = Status.initial,
    this.error,
    this.showTextFieldError = false,
    this.leaveType = LeaveType.casualLeave,
    required this.startDate,
    required this.endDate,
    required this.selectedDates,
    this.totalLeaveDays = 1,
    this.reason = "",
    this.attachment,
    this.availableLeaveDays = const {LeaveType.casualLeave: 21, LeaveType.urgentLeave: 5},

  });

  ApplyLeaveState copyWith({
    String? leaveId,
    Status? leaveRequestStatus,
    bool? showTextFieldError,
    LeaveType? leaveType,
    DateTime? startDate,
    DateTime? endDate,
    Map<DateTime, LeaveDayDuration>? selectedDates,
    double? totalLeaveDays,
    String? reason,
    String? error,
        File? attachment,

  }) {
    return ApplyLeaveState(
        leaveId: leaveId ?? this.leaveId,
        leaveRequestStatus: leaveRequestStatus ?? this.leaveRequestStatus,
        error: error,
        showTextFieldError: showTextFieldError ?? this.showTextFieldError,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        leaveType: leaveType ?? this.leaveType,
        reason: reason ?? this.reason,
        selectedDates: selectedDates ?? this.selectedDates,
        totalLeaveDays: totalLeaveDays ?? this.totalLeaveDays,
        attachment: attachment ?? this.attachment,
);
  }

  bool get isFailure => error != null && leaveRequestStatus == Status.error;

  @override
  List<Object?> get props => [
        leaveId,
        leaveRequestStatus,
        error,
        showTextFieldError,
        leaveType,
        startDate,
        selectedDates,
        endDate,
        totalLeaveDays,
        reason
      ];
}
