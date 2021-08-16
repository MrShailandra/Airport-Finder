import 'package:airport_finder/screens/details_screen.dart';
import 'package:airport_finder/screens/download_screen.dart';
import 'package:airport_finder/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(AirportApplication());
}

class AirportApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.amber),
        title: "Airport Finder",
        home: HomeScreen(),
      ),
    );
  }
}
