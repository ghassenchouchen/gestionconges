import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pfeconges/data/repo/employee_repo.dart';
import 'package:pfeconges/data/core/exception/error_const.dart';
import 'package:pfeconges/data/model/employee/employee.dart';
import 'package:pfeconges/ui/user/members/members_screen/bloc/user_members_bloc.dart';
import 'package:pfeconges/ui/user/members/members_screen/bloc/user_members_event.dart';
import 'package:pfeconges/ui/user/members/members_screen/bloc/user_members_state.dart';
import 'user_employees_test.mocks.dart';

@GenerateMocks([EmployeeRepo])
void main() {
  late EmployeeRepo employeeRepo;
  late UserEmployeesBloc bloc;

  final employee = Employee(
    uid: 'id',
    role: Role.admin,
    name: 'Flen Fleni',
    employeeId: '',
    email: 'flen.fln@visto-consulting.com',
    designation: 'Flutter developer',
    dateOfJoining: DateTime(2000),
  );

  setUpAll(() {
    employeeRepo = MockEmployeeRepo();
    bloc = UserEmployeesBloc(employeeRepo);
  });

  group('User Employees Bloc', () {
    test('Emits initial state after user employees screen are open', () {
      expect(bloc.state, UserEmployeesInitialState());
    });

    test(
        'Emits Loading state while fetching data from database and the emits success state with list of employees',
        () {
      when(employeeRepo.activeEmployees)
          .thenAnswer((realInvocation) => Stream.value([employee, employee]));
      bloc.add(FetchEmployeesEvent());
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserEmployeesLoadingState(),
            UserEmployeesSuccessState(employees: [employee, employee])
          ]));
    });

    test('Emits failure state when Exception is thrown from any cause', () {
      when(employeeRepo.activeEmployees)
          .thenThrow(Exception(firestoreFetchDataError));
      bloc.add(FetchEmployeesEvent());
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserEmployeesLoadingState(),
            UserEmployeesFailureState(error: firestoreFetchDataError)
          ]));
    });

    test('Emits failure state when stream get error', () {
      when(employeeRepo.activeEmployees).thenAnswer(
          (realInvocation) => Stream.error(firestoreFetchDataError));
      bloc.add(FetchEmployeesEvent());
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserEmployeesLoadingState(),
            UserEmployeesFailureState(error: firestoreFetchDataError)
          ]));
    });
  });
}
