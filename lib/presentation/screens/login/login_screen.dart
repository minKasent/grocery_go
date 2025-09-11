import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/presentation/bloc/login/login_bloc.dart';
import 'package:grocery_go/presentation/bloc/login/login_event.dart';
import 'package:grocery_go/presentation/bloc/login/login_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';
import 'package:grocery_go/presentation/routes/route_name.dart';
import 'package:grocery_go/presentation/shared/app_button.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/shared/common_dialogs.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// type - safe
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(FailureMapper(context)),
      child: BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColorSchemes.lightWhite,
              toolbarHeight: 100,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Assets.images.backgroundGradient.provider(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          content: "Loging",
                          style: AppTypography.text26w600,
                        ),
                        AppText(
                          content: "Enter your emails and password",
                          style: AppTypography.text16w400.copyWith(
                            color: AppColorSchemes.grey,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        AppText(content: "Email",style: AppTypography.text16w600,)
                      ],
                    ),
                  ),
                  TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(content: "Password",style: AppTypography.text16w600,),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: state.isHidePass,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          context.read<LoginBloc>().add(
                            OnTogglePasswordEvent(),
                          );
                        },
                        child: Icon(
                          state.isHidePass
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password action
                      },
                      child: Text(
                        'Forgot Password?',
                        style: AppTypography.text14w600
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  AppButton(
                    title: 'Log In',
                    onTap: () {
                      context.read<LoginBloc>().add(
                        OnLoginEvent(
                          username: _userNameController.text.trim(),
                          password: _passwordController.text.trim(),
                        ),
                      );
                    }, backgroundColor: AppColorSchemes.green,
                  ),
                  const SizedBox(height: 20,),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: AppTypography.text14w600.copyWith(color: AppColorSchemes.black),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: AppTypography.text14w600.copyWith(color: AppColorSchemes.green),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go(RouteName.account);
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.isLoading) {
            CommonDialogs.showLoadingDialog(context);
          } else {
            CommonDialogs.hideLoadingDialog(context);
            if (state.apiErrorMessage.isNotEmpty) {
              CommonDialogs.showAlertDialog(
                context,
                title: 'Error',
                message: state.apiErrorMessage,
                onPressed: () => context.read<LoginBloc>().add(
                  OnClearLoginErrorMessageEvent(),
                ),
              );
            } else if (state.isSuccess) {
              context.go(RouteName.dashboard);
            }
          }
        },
      ),
    );
  }
}
