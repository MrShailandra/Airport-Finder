import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0.5,
      title: Text("Airport Finder",
          style: GoogleFonts.getFont('Bebas Neue', fontSize: 26.sp)),
    );
  }

  Size get preferredSize => Size.fromHeight(45.h);
}
