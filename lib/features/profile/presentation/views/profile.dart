import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/routing/routes.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';
import 'package:recipe_finder/features/profile/data/repos/profile_repo.dart';
import 'package:recipe_finder/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:recipe_finder/features/profile/presentation/widgets/custom_info_list.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(ProfileRepo())..getProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.secondaryColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Profile",
                style: AppTextStyles.s30Bold.copyWith(fontSize: 18),
              ),
              centerTitle: true,
              backgroundColor: AppColors.secondaryColor,
            ),
            body: state is ProfileLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ),
                  )
                : state is ProfileLoaded
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: AppColors.lightBlueColor,
                                    child: Icon(Icons.person, size: 40),
                                  ),
                            
                                  const SizedBox(height: 10),
                            
                                  Text(
                                    state.data['name'] ?? "",
                                    style: AppTextStyles.s30Bold.copyWith(
                                      fontSize: 24
                                    ),
                                  ),
                            
                                  const SizedBox(height: 6),
                            
                                  Text(
                                    state.data['email'] ?? "",
                                    style: AppTextStyles.s16Regular,
                                  ),
                            
                             ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Account'.toUpperCase(),
                                style: AppTextStyles.s30Bold.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomInfoList(
                            icon: Icons.person,
                            text: "Edit Profile",
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                Routes.editProfile,
                              );

                              // ignore: use_build_context_synchronously
                              context.read<ProfileCubit>().getProfile();
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomInfoList(
                            icon: Icons.lock,
                            text: "Change Password",
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Prefrences'.toUpperCase(), style:  AppTextStyles.s30Bold.copyWith(fontSize: 14),),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomInfoList(
                            icon: Icons.dark_mode,
                            text: "Dark Mode",
                          ),
                          const SizedBox(height: 20),
                          CustomInfoList(
                            icon: Icons.language,
                            text: "Language",
                          ),

                          SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffFEF2F2),
                              ),
                              onPressed: () {
                                context.read<ProfileCubit>().logout();
                              },
                              child: const Text(
                                "Log Out",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          );
        },
      ),
    );
  }
}
