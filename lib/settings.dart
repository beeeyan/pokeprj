import 'package:flutter/material.dart';
import 'package:pokeprj/theme_mode_notifier.dart';
import 'package:pokeprj/theme_mode_section_page.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  void initState() {
    super.initState();
    // loadThemeModeが呼ばれたときに、valを_themeModeに設定する。
    // loadThemeMode().then((val) => setState(() => _themeMode = val));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(builder: (context, modeNotifier, snapshot) {
      return ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: const Text('Dark/Light Mode'),
            trailing: Text((modeNotifier.mode == ThemeMode.system)
                ? 'System'
                : (modeNotifier.mode == ThemeMode.dark ? 'Dark' : 'Light')),
            onTap: () async {
              final ret = await Navigator.of(context).push<ThemeMode>(
                MaterialPageRoute(
                  builder: (context) => ThemeModeSelectionPage(mode: modeNotifier.mode),
                ),
              );
              // retがnullでなければ更新
              if (ret != null) {
                modeNotifier.update(ret);
              }
            },
          ),
          SwitchListTile(
            title: const Text('Switch'),
            value: true,
            onChanged: (yes) => {},
          ),
          CheckboxListTile(
            title: const Text('Checkbox'),
            value: true,
            onChanged: (yes) => {},
          ),
          RadioListTile(
            title: const Text('Radio'),
            value: true,
            groupValue: true,
            onChanged: (yes) => {},
          ),
        ],
      );
    });
  }
}
