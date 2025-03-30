import 'package:casemet/provider/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SocialMediaIcons extends StatefulWidget {
  final bool isHindi;
  const SocialMediaIcons({super.key, required this.isHindi});

  @override
  State<SocialMediaIcons> createState() => _SocialMediaIconsState();
}

class _SocialMediaIconsState extends State<SocialMediaIcons> {
  late bool _isHindi;

  @override
  void initState() {
    super.initState();
    _isHindi = widget.isHindi;
  }

  String translate(String englishText, String hindiText) {
    return _isHindi ? hindiText : englishText;
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Provider.of<ThemeProviderState>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                translate('Follow Us', 'हमें फॉलो करें'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeData.isDarkMode
                      ? Colors.deepPurpleAccent
                      : Colors.deepPurple,
                ),
              ),
            ),
            // Switch(
            //   value: _isHindi,
            //   onChanged: (value) {
            //     setState(() {
            //       _isHindi = value;
            //     });
            //   },
            //   activeColor: Colors.blue,
            // ),
          ],
        ),
        // SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.facebook,
                color: Colors.blueAccent,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.instagram,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.linkedin,
                color: Colors.blue,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.youtube,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.xTwitter,
                // color: Colors.blue,
              ),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '© 2024-25 Case Met. All Rights Reserved.',
              style: TextStyle(
                fontSize: 12,
                color: themeData.isDarkMode
                    ? Colors.deepPurpleAccent
                    : Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
