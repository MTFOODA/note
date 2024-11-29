import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:provider/provider.dart';
import '../utilities/theme_provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // TickerProviderStateMixin provides the `vsync`
      duration: const Duration(milliseconds: 1000),
    );

    // Initialize the animation state based on the initial theme
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _isDarkMode = themeProvider.isDarkMode;
    if (_isDarkMode) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleTheme();
    setState(() {
      _isDarkMode = !_isDarkMode;
    });

    if (_isDarkMode) {
      _animationController.forward();
    } else {
      _animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final languages = {
      'en': 'English'.tr(),
      'ar': 'Arabic'.tr(),
      'fr': 'French'.tr(),
      'de': 'German'.tr(),
    };

    return AppBar(
      title: Text(widget.title.tr()),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: context.locale.languageCode, // Current language
              onChanged: (String? value) {
                if (value != null) {
                  context.setLocale(Locale(value));
                }
              },
              items: languages.entries.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: _toggleTheme,
          child: SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: Lottie.asset(
                'assets/lottie/dm.json',
                controller: _animationController,
                onLoaded: (composition) {
                  _animationController.duration = composition.duration;
                  if (_animationController.isCompleted) {
                    _animationController.reset();
                  }
                },
                repeat: false,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.logout, size: 40),
          onPressed: () async {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}
