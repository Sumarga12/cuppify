import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/profile_cubit.dart';
import '../widgets/edit_profile_dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Failed to load profile data'),
                if (kDebugMode) ...[
                  const SizedBox(height: 16),
                  Text(state.message),
                ],
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<ProfileCubit>().getProfile(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is ProfileLoaded) {
          return Scaffold(
            // Changed background color to white
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 75,
                              backgroundImage: state.profile.image != null
                                  ? CachedNetworkImageProvider(
                                      state.profile.image!,
                                    )
                                  : null,
                              child: state.profile.image == null
                                  ? const Icon(Icons.person,
                                      size: 75, color: Colors.white)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            onPressed: () {
                              final cubit = context.read<ProfileCubit>();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    BlocProvider.value(
                                  value: cubit,
                                  child: EditProfileDialog(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit, color: Colors.white),
                            label: const Text(
                              'Edit Profile',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Green
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    // User information section
                    _buildInfoSection('Full Name:', state.profile.name),
                    const SizedBox(height: 24),
                    _buildInfoSection('Email:', state.profile.email),
                    if (state.profile.phone != null) ...[
                      const SizedBox(height: 24),
                      _buildInfoSection('Address:', state.profile.phone!),
                    ],
                  ],
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildInfoSection(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
