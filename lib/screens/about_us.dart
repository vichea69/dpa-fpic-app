import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fpic_app/main.dart';
import 'package:fpic_app/widgets/screen_background.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  Future<void> _launchUri(BuildContext context, Uri uri) async {
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot open link')),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to open link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meta = App.meta;
    final appName = meta?.app_name ?? 'FPIC App';
    final phone = '+85523883665';
    final email = 'support@dpacam.org';
    final website = 'https://www.dpacam.org';

    return Scaffold(
        appBar: AppBar(title: const Text('About us')),
        body: ScreenBackground(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Image.asset('assets/logo_fpic.png',
                    height: 88, fit: BoxFit.contain),
                const SizedBox(height: 12),
                Text(appName, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Version 2.0.5',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 1,
                  
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone'),
                  subtitle: Text(phone),
                  onTap: () => _launchUri(context, Uri.parse('tel:$phone')),
                ),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text('Email'),
                  subtitle: Text(email),
                  onTap: () => _launchUri(context, Uri.parse('mailto:$email')),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Website'),
                  subtitle: Text(website),
                  onTap: () => _launchUri(context, Uri.parse(website)),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Visit website'),
                  onPressed: () => _launchUri(context, Uri.parse(website)),
                ),
                const SizedBox(height: 290),
              ],
            ),
          ),
        ));
  }
}
