import 'package:flutter/material.dart';

/**
 * InkWell(
                  onTap: () {
                    changeLanguage(context, 'es');
                    log("knf");
                  },
                  child: Text(Languages
              .of(context)
              ?.alreadyHaveAnAccount ?? "N/A")),
 */
abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get login;
}
