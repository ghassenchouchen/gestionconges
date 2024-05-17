import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pfeconges/app_router.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/style/app_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfeconges/style/other/animated_text_popup.dart';
import '../../data/core/utils/const/image_constant.dart';
import '../../data/di/service_locator.dart';
import '../widget/error_snack_bar.dart';
import 'bloc/sign_in_view_bloc.dart';
import 'bloc/sign_in_view_event.dart';
import 'bloc/sign_in_view_state.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInBloc>(),
      child: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _UserController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      final email = _UserController.text;
      final password = _passwordController.text;
      BlocProvider.of<SignInBloc>(context)
          .add(EmailPasswordSignInEvent(email: email, password: password));
    }
  }

  bool _obscureText = true;

  bool isInternetLost = false; // Flag to track internet connectivity

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
    return BlocConsumer<SignInBloc, SignInState>(listener: (context, state) {
      if (state.signInSuccess) {
        context.goNamed(Routes.userHome);
      } else if (state.error != null && state.error!.isNotEmpty) {
        showCustomFailureAlert(context, "Veuillez vérifier vos informations!");
      }
    }, builder: (context, state) {
       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Change this to your desired color
  ));
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                child: Image.asset(
                  'assets/images/background.jpeg',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
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
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 5,
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
                          /*BlocBuilder<SignInBloc, SignInState>(
                                builder: (BuildContext context, state) {
                                  if (state is SignInNotValidState) {
                                    return Text(
                                      state.message,
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          letterSpacing: 0,
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),*/
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
                          SizedBox(height: 25),
                          TextFormField(
                            controller: _UserController,
                            decoration: InputDecoration(
                              labelText: 'Nom d\'utilisateur',
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                              suffixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: EdgeInsets.all(18),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre Nom d\'utilisateur';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: EdgeInsets.all(18),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                showCustomWarningAlert(context,
                                    "Veuillez remplir les champs nécessaires!");
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(right: 20, bottom: 20),
                              child: InkWell(
                                onTap: () {
                                  // TODO: Handle "forgot password" logic here
                                },
                                child: Text(
                                  'Mot de passe oublié?',
                                  style: TextStyle(color: Colors.blue[800]),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
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
                              if (_formKey.currentState!.validate()) {
                                context.read<SignInBloc>().add(
                                    EmailPasswordSignInEvent(
                                        email: _UserController.text,
                                        password: _passwordController.text));
                              }
                            },
                            child: BlocBuilder<SignInBloc, SignInState>(
                              builder: (context, state) {
                                return state.emailPasswordSignInLoading
                                    ? const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ) // Show loading indicator
                                    : const Text(
                                        "S\'identifier",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                              },
                            ),
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
    });
  }
}
