import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pfeconges/data/repo/employee_repo.dart';
import 'package:pfeconges/data/core/exception/error_const.dart';
import 'package:pfeconges/data/model/employee/employee.dart';
import 'package:pfeconges/ui/shared/profile/view_profile/bloc/view_profile_event.dart';
import 'package:pfeconges/ui/shared/profile/view_profile/bloc/view_profile_state.dart';
import '../../../../../data/provider/user_state.dart';

@Injectable()
class ViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfileState> {
  final UserStateNotifier _userManager;
  final EmployeeRepo _employeeRepo;

  ViewProfileBloc(this._userManager, this._employeeRepo)
      : super(ViewProfileInitialState()) {
    on<InitialLoadevent>(_initialLoad);
  }

  Future<void> _initialLoad(
      InitialLoadevent event, Emitter<ViewProfileState> emit) async {
    emit(ViewProfileLoadingState());
    try {
      return emit.forEach(_employeeRepo.memberDetails(_userManager.employeeId),
          onData: (Employee? employee) {
            if (employee == null) {
              return ViewProfileErrorState(firestoreFetchDataError);
            } else {
              return ViewProfileSuccessState(employee);
            }
          },
          onError: (error, stackTrace) =>
              ViewProfileErrorState(firestoreFetchDataError));
    } on Exception {
      emit(ViewProfileErrorState(firestoreFetchDataError));
    }
  }
}
