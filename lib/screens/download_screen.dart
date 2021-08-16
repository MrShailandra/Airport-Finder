import 'dart:io';
import 'package:airport_finder/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flowder/flowder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class DownloadScreen extends StatefulWidget {
  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  late DownloaderUtils options;
  late DownloaderCore core;
  late final String path;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    Timer(Duration(seconds: 2), () {
      getFile();
    });
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    path = (await getExternalStorageDirectory())!.path;
  }

  void getFile() async {
    print(path);
    if (await File("$path/country.json").exists() != true) {
      downloadFile();
    } else {
      print("File is Already Exist");
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  }

  downloadFile() async {
    options = DownloaderUtils(
      progressCallback: (current, total) {
        final progress = (current / total) * 100;
        print('Downloading: $progress');
      },
      file: File('$path/country.json'),
      progress: ProgressImplementation(),
      onDone: () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen())),
      deleteOnCancel: true,
    );
    core = await Flowder.download(
        'https://raw.githubusercontent.com/mwgg/Airports/master/airports.json',
        options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        title: Text("Airport Finder",
            style: GoogleFonts.getFont('Bebas Neue', fontSize: 26.sp)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitPouringHourglass(
            color: Colors.amber,
            size: 75.0.sp,
          ),
          SizedBox(
            height: 20,
          ),
          Text("Please Wait While We Make This App To Work in Offline Mode",
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont('Roboto Slab', fontSize: 14.sp)),
        ],
      ),
    );
  }
}
