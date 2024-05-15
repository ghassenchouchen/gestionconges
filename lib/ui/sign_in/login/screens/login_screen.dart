/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/data/di/service_locator.dart';
import 'package:pfeconges/data/provider/user_state.dart';
import 'package:pfeconges/style/colors.dart';
import 'package:pfeconges/style/colors.dart';
import 'package:pfeconges/ui/login/bloc/loginEvents.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/bloc/network/network_connection_bloc.dart';
import '../../../data/bloc/network/network_connection_state.dart';
import '../../../data/services/auth_service.dart';
import '../../../style/colors.dart';
import '../../shared/dashboard/dashboard.dart';
import '../../user/leaves/apply_leave/apply_leave_screen.dart';
import '../bloc/loginState.dart';
import '../../../style/other/animated_text_popup.dart';
import '../bloc/loginbloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInBloc>(),
      child: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

enum UserType { employee, admin }

class LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController addToCartPopUpAnimationController;
  AuthService _authService = AuthService();
  //final EmpDashRepository _repository = EmpDashRepository();
  //late List<EmpDashModel> empDashData;
  // final EmpAttendanceRepository _attendanceRepository =
  //  EmpAttendanceRepository();
  //late EmpAttendanceModel empAttendanceData;
  @override
  void initState() {
    addToCartPopUpAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    //saveEmpAllToShared();
    super.initState();
  }

  @override
  void dispose() {
    addToCartPopUpAnimationController.dispose();
    super.dispose();
  }

  UserType? _selectedUserType = UserType.admin;
  final _passwordController = TextEditingController();
  final _UserController = TextEditingController();
  bool _obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool _isButtonPressed = false;
  static const String KEY_LOGIN = "Login";
  //final UserRepository userRepository = UserRepository();

  void _saveAdminDataToSharedPreferences(String username) async {
    /*
    final sharedPref = await SharedPreferences.getInstance();
    GlobalObjects.adminusername = username;
    sharedPref.setString('admin_username', username);*/
  }

  String? savedEmpCode;

  Future<void> fetchProfileData() async {}

  void _loginAsEmployee() async {
    showCustomSuccessAlertEmployee(context, "Login Successful!");
    await fetchProfileData();
  }

  String? profileImageUrl;
  Future<void> saveEmpAllToShared() async {}

  void _saveCardNoToSharedPreferences(
      String cardNo, String empCode, int employeeId) async {}

  void _loginAsAdmin() async {
    print("Start _loginAsAdmin");

    print("End _loginAsAdmin");
  }

  Future<void> saveAdminToDatabase(String username) async {}

  void showPopupWithMessageFailed(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return addToCartPopUpFailed(addToCartPopUpAnimationController, message);
      },
    );
  }

  void showPopupWithMessageSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return addToCartPopUpSuccess(
            addToCartPopUpAnimationController, message);
      },
    );
  }

  void showPopupWithMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return addToCartPopUpNoCrossMessage(
            addToCartPopUpAnimationController, message);
      },
    );
  }

  void _onLoginButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isButtonPressed = true;
      });

      await Future.delayed(const Duration(seconds: 1));
      var sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(KEY_LOGIN, true);

      try {
        var email = _UserController.text;
        var password = _passwordController.text;

        // Perform login and get user
        await _authService.login(email, password);
      final token = await _authService.secureStorage.read(key: 'jwt');




          print("login successful");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ApplyLeavePage()),
          );
          print('user is null');
        
      } catch (e) {
        print("login failed with exception: $e");
      } finally {
        setState(() {
          _isButtonPressed = false;
        });
      }
    } else {
      showCustomWarningAlert(
          context, "Veuillez remplir les champs nécessaires!");
    }
  }

  bool isInternetLost = false;

  double getSize() {
    double containerHeight = MediaQuery.of(context).size.height;

    if (containerHeight > 930) {
      return 0.78;
    } else if (containerHeight > 900) {
      return 0.7;
    } else if (containerHeight > 720) {
      return 0.7;
    } else if (containerHeight > 600) {
      return 0.68;
    } else {
      return 0.65;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return BlocConsumer<NetworkConnectionBloc, NetworkConnectionState>(
        listener: (context, state) {
      // TODO: implement listener
      if (state is NetWorkConnectionSuccessState) {
        // Check if internet was previously lost
        if (isInternetLost) {
          // Navigate back to the original page when internet is regained
          Navigator.pop(context);
        }
        isInternetLost = false; // Reset the flag
      }
    }, builder: (context, state) {
      //if (state is InternetGainedState) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                child: Image.asset(
                  'assets/images/background.jpeg',
                  fit: BoxFit.fill, // Cover the entire screen
                  width: double
                      .infinity, // Make sure the image covers the entire width
                  height: double
                      .infinity, // Make sure the image covers the entire height
                ),
              ),
              Container(
                color: context.colorScheme.primary.withOpacity(0.7),
              ),
              Positioned(
                top: 90,
                left: MediaQuery.of(context).size.width * 0.5 - 150,
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.5), // Shadow color with opacity
                        offset: Offset(2, 2), // Shadow offset
                        blurRadius: 5, // Blur radius
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * getSize()
                          : MediaQuery.of(context).size.width * 0.55,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, -2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          BlocBuilder<SignInBloc, SignInState>(
                            builder: (BuildContext context, state) {
                              if (state is SignInNotValidState) {
                                return Text(
                                  state.message,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      letterSpacing: 0,
                                      fontSize: 15,
                                      //color: context.colorScheme.primary,
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "Révolutionner le congé!",
                                    style: TextStyle(
                                      color: context.colorScheme.primary,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25), // Add more spacing
                          TextFormField(
                            controller: _UserController,
                            decoration: InputDecoration(
                              labelText: 'Nom d\'utilisateur',
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                              suffixIcon: Icon(FontAwesomeIcons.user),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Add border radius
                              ),
                              contentPadding: EdgeInsets.all(18),
                            ), // Add this line to make it boxed

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre Nom d\'utilisateur';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30), // Add more spacing
                          TextFormField(
                            controller: _passwordController,
                            onChanged: (value) {
                              BlocProvider.of<SignInBloc>(context).add(
                                SignInTextChangedEvent(
                                  password: _passwordController.text,
                                ),
                              );
                            },
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                              //suffixIcon: Icon(FontAwesomeIcons.lock),

                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Add border radius
                              ),
                              contentPadding: EdgeInsets.all(18),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre mot de passe';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 20.0, bottom: 20.0),
                              child: InkWell(
                                onTap: () {
                                  //Get.to(() => ForgotPassScreen(),
                                  (fullscreenDialog: true);
                                },
                                child: Text(
                                  'Mot de passe oublié?',
                                  style: TextStyle(color: Colors.blue[800]),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          BlocBuilder<SignInBloc, SignInState>(
                            builder: (BuildContext context, state) {
                              return ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                    const Size(250, 50),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      context.colorScheme.primary),
                                  elevation: MaterialStateProperty.all(3),
                                  shadowColor:
                                      MaterialStateProperty.all(Colors.grey),
                                ),
                                onPressed: () {
                                  _onLoginButtonPressed();
                                },
                                child: _isButtonPressed
                                    ? const SizedBox(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          color: Colors.white,
                                        ),
                                        width: 15.0,
                                        height: 15.0,
                                      )
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height > 700
                                ? 200
                                : 20,
                          ),
                          Text(
                            "Visto Consulting",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } /*else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }*/
        );
  }
}
*/