import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_cubit.dart';
import '../../blocs/auth/auth_state.dart';
import '../../core/constants.dart';
import '../../core/utils/validators.dart';
import '../../routes.dart';
import '../components/loading_indicator.dart';
import '../components/snack_bar.dart';
import '../components/text_field.dart';
import '../components/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';
  FocusNode passwordFocusNode = FocusNode();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.authenticated) {
                Navigator.pushReplacementNamed(context, Routes.products);
              } else if (state.status == AuthStatus.error) {
                SnackBarHelper.showError(context, state.error!);
              }
            },
            child: LayoutBuilder(builder: (context, constraints) {
              final height = constraints.maxHeight;
              return Stack(
                children: [
                  Container(
                    height: height * 0.4,
                    decoration: const BoxDecoration(
                      color: AppColors.kMainContainer,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Wasil Store',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.kLightText,
                        ),
                      ),
                    ),
                  ),

                  // Login card
                  Center(
                    child: Card(
                      color: AppColors.kSecondaryContainer,
                      surfaceTintColor: AppColors.kMainContainer,
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Email field
                              CustomTextField(
                                nextFocusNode: passwordFocusNode,
                                hint: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: const Icon(Icons.email_outlined),
                                validator: Validators.validateEmail,
                                onChanged: (v) => _email = v.trim(),
                              ),
                              const SizedBox(height: 16),

                              // Password field
                              CustomTextField(
                                focusNode: passwordFocusNode,
                                hint: 'Password',
                                obscureText: _isObscure,
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () =>
                                      setState(() => _isObscure = !_isObscure),
                                ),
                                validator: Validators.validatePassword,
                                onChanged: (v) => _password = v.trim(),
                              ),
                              const SizedBox(height: 24),

                              // Login button / loading
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  if (state.status == AuthStatus.loading) {
                                    return const LoadingIndicator(template: 2);
                                  }
                                  return SizedBox(
                                    width: double.infinity,
                                    child: CustomButton.filled(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          authCubit.login(_email, _password);
                                        }
                                      },
                                      label: const Text(
                                        'Log In',
                                        style: TextStyle(
                                            color: AppColors.kLightText),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 5),
                              // Signup link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account?",
                                    style:
                                        TextStyle(color: AppColors.kDarkText),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, Routes.signup),
                                    child: const Text(
                                      "Sign up",
                                      style:
                                          TextStyle(color: AppColors.kMainText),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
