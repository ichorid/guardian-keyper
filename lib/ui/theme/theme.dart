import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const clIndigo900 = Color(0xFF1A0244);
const clIndigo800 = Color(0xFF300077);
const clIndigo700 = Color(0xFF3C089F);
const clIndigo600 = Color(0xFF5600D6);
const clIndigo500 = Color(0xFF570FE4);
const clSurface = Color(0xFF24035F);
const clRed = Color(0xFFEC5F59);
const clGreen = Color(0xFF62D6CB);
const clGreenDark = Color(0xFF004D45);
const clBlue = Color(0xFF54BAF9);
const clYellow = Color(0xFFF19C38);
const clPurpleLight = Color(0xFFE6DEF8);
const clWhite = Colors.white;
const clBlack = Colors.black;

const paddingAll8 = EdgeInsets.all(8);
const paddingAll20 = EdgeInsets.all(20);
const paddingH20 = EdgeInsets.symmetric(horizontal: 20);
const paddingV6 = EdgeInsets.symmetric(vertical: 6);
const paddingV12 = EdgeInsets.symmetric(vertical: 12);
const paddingV20 = EdgeInsets.symmetric(vertical: 20);
const paddingV32 = EdgeInsets.symmetric(vertical: 32);
const paddingT12 = EdgeInsets.only(top: 12);
const paddingT20 = EdgeInsets.only(top: 20);
const paddingT32 = EdgeInsets.only(top: 32);
const paddingB12 = EdgeInsets.only(bottom: 12);
const paddingB20 = EdgeInsets.only(bottom: 20);
const paddingB32 = EdgeInsets.only(bottom: 32);

const radius8 = Radius.circular(8);

const borderRadiusTop10 = BorderRadius.vertical(top: Radius.circular(10));

final borderRadius8 = BorderRadius.circular(8);

final boxDecoration = BoxDecoration(
  borderRadius: borderRadius8,
  color: clSurface,
);

final styleSourceSansPro412 = GoogleFonts.sourceSansPro(
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

final styleSourceSansPro414 = GoogleFonts.sourceSansPro(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

final styleSourceSansPro414Purple = GoogleFonts.sourceSansPro(
  color: clPurpleLight,
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

final styleSourceSansPro416 = GoogleFonts.sourceSansPro(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

final styleSourceSansPro416Purple = GoogleFonts.sourceSansPro(
  color: clPurpleLight,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

final styleSourceSansPro612 = GoogleFonts.sourceSansPro(
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

final styleSourceSansPro612Purple = GoogleFonts.sourceSansPro(
  color: clPurpleLight,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

final styleSourceSansPro614 = GoogleFonts.sourceSansPro(
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

final styleSourceSansPro616 = GoogleFonts.sourceSansPro(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

final styleSourceSansPro616Purple = GoogleFonts.sourceSansPro(
  color: clPurpleLight,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

final stylePoppins616 = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

final stylePoppins620 = GoogleFonts.poppins(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);
