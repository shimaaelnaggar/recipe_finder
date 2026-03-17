import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/constants/app_icons.dart';
import 'package:recipe_finder/core/constants/app_images.dart';
import 'package:recipe_finder/core/routing/routes.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';
import 'package:recipe_finder/core/widgets/custom_button.dart';
import 'package:recipe_finder/core/widgets/custom_text_form_field.dart';
import 'package:recipe_finder/core/widgets/functions.dart';
import 'package:recipe_finder/features/auth/data/repos/auth_repo.dart';
import 'package:recipe_finder/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:recipe_finder/features/auth/presentation/widgets/custom_text.dart';
import 'package:recipe_finder/features/auth/presentation/widgets/custom_text_button.dart';
import 'package:recipe_finder/features/auth/presentation/widgets/social_media_section.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  @override
  initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepo()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            snackBar(
              text: state.errorMessage,
              context: context,
              color: Color(AppColors.errorColor),
            );
          } else if (state is LoginSuccessState) {
            snackBar(
              text: 'Login successful',
              context: context,
              color: Color(AppColors.successColor),
            );
            Navigator.pushReplacementNamed(context, Routes.layout);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                AppIcons.appIcon,
                                fit: BoxFit.contain,
                                height: 60,
                              ),
                            ),
                            Text(
                              'Recipe Finder',
                              style: AppTextStyles.s30Bold.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Image.asset(
                          AppImages.meal,
                          fit: BoxFit.contain,

                          width: double.infinity,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Welcome Back',
                          style: AppTextStyles.s30Bold.copyWith(fontSize: 32),
                        ),
                        const SizedBox(height: 8),

                        const Text(
                          "Sign in to continue your culinary journey",
                          style: AppTextStyles.s16Regular,
                        ),

                        const SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: 'Email'),
                            CustomTextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+',
                                ).hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              hint: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icon(
                                Icons.email,
                                color: AppColors.darkGray,
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 20),
                            CustomText(text: 'Password'),
                            CustomTextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              hint: 'Enter your password',
                              obscureText: obscurePassword,
                              keyboardType: TextInputType.visiblePassword,
                              suffixIcon: obscurePassword
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.visibility_off,
                                        color: AppColors.darkGray,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          obscurePassword = false;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.visibility,
                                        color: AppColors.darkGray,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          obscurePassword = true;
                                        });
                                      },
                                    ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: AppColors.darkGray,
                              ),
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Forgot Password?',
                                  style: AppTextStyles.s14SemiBold.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            state is LoginLoadingState
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.secondaryColor,
                                    ),
                                  )
                                : CustomButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().signIn(
                                          email: emailController.text.trim(),
                                          password: passwordController.text
                                              .trim(),
                                        );
                                      }
                                    },
                                    text: 'login',
                                  ),
                            SizedBox(height: 20),
                            SocialMediaSection(),
                            SizedBox(height: 20),
                            CustomTextButton(
                              text: "Don't have an account?",
                              buttonText: 'Sign Up',
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.signUp);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
