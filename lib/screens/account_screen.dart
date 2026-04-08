import 'package:flutter/material.dart';
import 'package:fpic_app/main.dart';
import 'package:fpic_app/widgets/auth_service.dart';
import 'package:fpic_app/screens/login_screen.dart';
import 'package:fpic_app/screens/change_password.dart';
import 'package:fpic_app/screens/change_profile_screen.dart';
import 'package:fpic_app/screens/about_us.dart';
import 'package:fpic_app/screens/setting_screen.dart';
import 'package:fpic_app/widgets/screen_background.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If the app meta indicates login flow, require login to view account.
    final firstText = App.meta?.first_logo_section_text ?? '';
    final requiresLogin = firstText.trim().toLowerCase() == 'login';
    if (requiresLogin && !AuthService.isLoggedIn) {
      return Scaffold(
        body: ScreenBackground(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Please sign in to view your account.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text('Sign in'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
        body: ScreenBackground(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 20),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: Icon(Icons.person,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  title: const Text('Change profile'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const ChangeProfileScreen()),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.withOpacity(0.1),
                    child: const Icon(Icons.lock, color: Colors.orange),
                  ),
                  title: const Text('Change password'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const ChangePasswordScreen()),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    child: const Icon(Icons.info_outline, color: Colors.blue),
                  ),
                  title: const Text('About us'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AboutUsScreen()),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.08),
                    child: const Icon(Icons.settings, color: Colors.grey),
                  ),
                  title: const Text('Setting'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SettingScreen()),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.08),
                    child:
                        const Icon(Icons.verified_outlined, color: Colors.grey),
                  ),
                  title: const Text('Version'),
                  trailing: const Text('2.0.5',
                      style: TextStyle(color: Colors.black54)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () => _confirmLogout(context),
          ),
        ],
      ),
    ));
  }

  Widget _buildProfileHeader(BuildContext context) {
    // Placeholder data — replace with real user data when available.
    const fullName = 'Admin';
    const email = '';

    return Row(
      children: [
        const CircleAvatar(
          radius: 36,
          backgroundImage: AssetImage('assets/person1.png'),
          // If you don't have an asset, replace with a child Text or default icon.
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 13),
              Text(fullName, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(email, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        // IconButton(
        //   icon: const Icon(Icons.edit_outlined),
        //   onPressed: () {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text('Edit profile')),
        //     );
        //   },
        // ),
      ],
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await AuthService.logout();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out')),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }
}
