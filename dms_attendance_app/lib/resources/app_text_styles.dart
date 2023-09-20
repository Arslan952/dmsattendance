import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'resources.dart';

class AppTextStyles {
  TextStyle poppins({
    Color? color,
    double? fs,
    FontWeight? fw,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fs ?? 15.sp,
      color: color ?? R.colors.white,
      fontWeight: fw ?? FontWeight.w600,
      letterSpacing: letterSpacing ?? 0.4,
      height: height ?? 1,
    );
  }
}
