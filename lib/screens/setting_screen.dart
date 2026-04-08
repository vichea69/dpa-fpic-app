import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fpic_app/screens/about_us.dart';
import 'package:fpic_app/widgets/screen_background.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notifications = true;
  bool _darkMode = false;
  String _language = 'English';

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notifications = prefs.getBool('settings.notifications') ?? true;
      _darkMode = prefs.getBool('settings.darkMode') ?? false;
      _language = prefs.getString('settings.language') ?? 'English';
    });
  }

  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void _changeLanguage() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Select language'),
        children: [
          SimpleDialogOption(
            child: const Text('English'),
            onPressed: () => Navigator.of(ctx).pop('English'),
          ),
          SimpleDialogOption(
            child: const Text('Khmer'),
            onPressed: () => Navigator.of(ctx).pop('Khmer'),
          ),
        ],
      ),
    );
    if (selected != null && selected != _language) {
      setState(() => _language = selected);
      await _saveString('settings.language', selected);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Language updated')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ScreenBackground(
          child: ListView(
            children: [
              SwitchListTile(
                title: const Text('Notifications'),
                value: _notifications,
                onChanged: (v) {
                  setState(() => _notifications = v);
                  _saveBool('settings.notifications', v);
                },
              ),
              SwitchListTile(
                title: const Text('Dark mode'),
                value: _darkMode,
                onChanged: (v) {
                  setState(() => _darkMode = v);
                  _saveBool('settings.darkMode', v);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Toggle app theme as needed')));
                },
              ),
              ListTile(
                title: const Text('Language'),
                subtitle: Text(_language),
                trailing: const Icon(Icons.chevron_right),
                onTap: _changeLanguage,
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text('Privacy & policy'),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Open privacy policy'))),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About us'),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AboutUsScreen())),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings saved')));
                  },
                  child: const Text('Save settings'),
                ),
              ),
            ],
          ),
        ));
  }
}
