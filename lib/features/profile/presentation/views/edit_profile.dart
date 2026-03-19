import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';
import 'package:recipe_finder/core/widgets/custom_text_form_field.dart';
import 'package:recipe_finder/features/auth/presentation/widgets/custom_text.dart';
import 'package:recipe_finder/features/profile/data/repos/profile_repo.dart';
import 'package:recipe_finder/features/profile/presentation/cubit/profile_cubit.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final GlobalKey<FormState> formkey = GlobalKey();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(ProfileRepo())..getProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoaded && nameController.text.isEmpty) {
            nameController.text = state.data['name'] ?? '';
            emailController.text = state.data['email'] ?? '';
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.secondaryColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Center(
                child: Text(
                  "Edit Profile",
                  style: AppTextStyles.s30Bold.copyWith(fontSize: 18),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Full Name'),
                      CustomTextFormField(
                        controller: nameController,
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
                          color: AppColors.primaryColor,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      CustomText(text: 'Email'),
                      CustomTextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        hint: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColors.primaryColor,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 20),
                      CustomText(text: 'Password'),
                      CustomTextFormField(
                        controller: passwordController,

                        hint: 'Enter your password',
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,

                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColors.primaryColor,
                        ),
                        textInputAction: TextInputAction.done,
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              context.read<ProfileCubit>().updateProfile(
                                name: nameController.text,
                                email: emailController.text,
                              );
                            }
                          },
                          child: Text(
                            "Save Changes",
                            style: AppTextStyles.s18Bold.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
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
