import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_go/presentation/bloc/login/login_bloc.dart';
import 'package:grocery_go/presentation/bloc/login/login_event.dart';
import 'package:grocery_go/presentation/bloc/login/login_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';
import 'package:grocery_go/presentation/routes/route_name.dart';
import 'package:grocery_go/presentation/shared/app_button.dart';
import 'package:grocery_go/presentation/shared/common_dialogs.dart';

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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(controller: _userNameController),
                TextField(
                  controller: _passwordController,
                  obscureText: state.isHidePass,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        context.read<LoginBloc>().add(OnTogglePasswordEvent());
                      },
                      child: Icon(
                        state.isHidePass
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                AppButton(
                  title: 'Log In',
                  onTap: () {
                    context.read<LoginBloc>().add(
                      OnLoginEvent(
                        username: _userNameController.text.trim(),
                        password: _passwordController.text.trim(),
                      ),
                    );
                  },
                ),
              ],
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
