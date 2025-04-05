import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget haloButton(String text, VoidCallback onPressed, Color color) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.2),
        foregroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(text, style: const TextStyle(fontFamily: 'Courier')),
    );
  }

