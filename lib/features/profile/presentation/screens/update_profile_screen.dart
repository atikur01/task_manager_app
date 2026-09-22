import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_manager/features/profile/presentation/providers/profile_provider.dart';
import 'package:task_manager/features/auth/data/models/user_model.dart';
import 'package:task_manager/core/widgets/tm_appbar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserModel? user = context.read<AuthProvider>().userModel;
    if (user != null) {
      _emailController.text = user.email;
      _firstNameController.text = user.firstName;
      _lastNameController.text = user.lastName;
      _mobileController.text = user.mobile;
    }
  }

  Future<void> _updateProfile() async {
    final profileProvider = context.read<ProfileProvider>();
    final authProvider = context.read<AuthProvider>();

    final response = await profileProvider.updateProfile(
      email: _emailController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      mobile: _mobileController.text,
      password: _passwordController.text,
      token: authProvider.accessToken,
    );

    if (!mounted) return;

    if (response.isSuccess) {
      final UserModel? updatedUser =
          await profileProvider.fetchProfileDetails(authProvider.accessToken);

      if (updatedUser != null) {
        await authProvider.updateUserData(updatedUser);

        _emailController.text = updatedUser.email;
        _firstNameController.text = updatedUser.firstName;
        _lastNameController.text = updatedUser.lastName;
        _mobileController.text = updatedUser.mobile;
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Updated success..!')),
      );
    } else {
      final errorMessage = response.responseData != null &&
              response.responseData is Map &&
              response.responseData['data'] != null
          ? response.responseData['data']
          : 'Profile update failed! Image might be too large.';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage.toString())),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TmAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text(
                  'Update profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 25),
                Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) {
                    return InkWell(
                      onTap: () {
                        profileProvider.pickImage();
                      },
                      child: Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: const Text('photo'),
                            ),
                            Expanded(
                              child: Text(
                                profileProvider.selectedImage?.name ?? '',
                                style:
                                    const TextStyle(overflow: TextOverflow.ellipsis),
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(hintText: 'First name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter First name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(hintText: 'Last name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _mobileController,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter phone number';
                    } else if (value.length != 11) {
                      return 'Please enter correct phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(height: 15),
                Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) {
                    if (profileProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _updateProfile();
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
