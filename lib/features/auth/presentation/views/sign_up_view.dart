import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/constants/app_icons.dart';
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

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController fullNameController;
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepo()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpErrorState) {
            snackBar(
              text: state.errorMessage,
              context: context,
              color: Color(AppColors.errorColor),
            );
          }
          if (state is SignUpSuccessState) {
            snackBar(
              text: 'Sign Up successful',
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
                      children: [
                        const SizedBox(height: 40),
                        Image.asset(
                          AppIcons.appIcon,
                          fit: BoxFit.contain,
                          height: 60,
                        ),
                        SizedBox(height: 30),
                        Text('Create Account', style: AppTextStyles.s30Bold),
                        SizedBox(height: 8),
                        Text(
                          'Join Our Community of Food Lovers',
                          style: AppTextStyles.s16Regular,
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: 'Full Name'),
                              CustomTextFormField(
                                controller: fullNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your full name';
                                  }
                                  return null;
                                },
                                hint: 'Enter your full name',
                                keyboardType: TextInputType.name,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.darkGray,
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 20),
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
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                  icon: !obscurePassword
                                      ? Icon(
                                          Icons.visibility,
                                          color: AppColors.darkGray,
                                        )
                                      : Icon(Icons.visibility_off),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: AppColors.darkGray,
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                              SizedBox(height: 20),
                              state is SignUpLoadingState
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  : CustomButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<AuthCubit>().signUp(
                                            name: fullNameController.text
                                                .trim(),
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim(),
                                          );
                                        }
                                      },
                                      text: 'signUp',
                                    ),
                              SizedBox(height: 20),
                              SocialMediaSection(),
                              SizedBox(height: 20),
                              CustomTextButton(
                                text: "Already have an account?",
                                buttonText: 'Sign In',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
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
