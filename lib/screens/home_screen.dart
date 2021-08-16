import 'dart:async';

import 'dart:io';
import 'package:airport_finder/screens/details_screen.dart';
import 'package:airport_finder/screens/download_screen.dart';
import 'package:airport_finder/services/http_service.dart';
import 'package:airport_finder/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final String path;
  bool result = false;
  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    path = (await getExternalStorageDirectory())!.path;
  }

  void getFile() async {
    if (await File("$path/country.json").exists() != true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DownloadScreen()));
    } else {
      print("File is Already Exist");
    }
  }

  void getInternet() async {
    result = await DataConnectionChecker().hasConnection;
  }

  HttpService httpService = HttpService();
  @override
  void initState() {
    initPlatformState();
    Timer(Duration(seconds: 2), () {
      print(path);
      getFile();
    });
    getInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: result ? httpService.getdata() : httpService.readJson(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitPouringHourglass(
              color: Colors.amber,
              size: 75.0.sp,
            );
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                name: snapshot.data[index].name,
                                icao: snapshot.data[index].icao,
                                city: snapshot.data[index].city,
                                state: snapshot.data[index].state,
                                country: snapshot.data[index].country,
                                tz: snapshot.data[index].tz,
                                lat: snapshot.data[index].lat,
                                lon: snapshot.data[index].lon,
                              ),
                            ));
                      },
                      child: Container(
                        height: 50.h,
                        width: double.infinity,
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data[index].name,
                                style: GoogleFonts.getFont('Roboto Slab',
                                    fontSize: 14.sp),
                              ),
                              Text(snapshot.data[index].icao,
                                  style: GoogleFonts.getFont('Lora',
                                      fontSize: 14.sp))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${snapshot.data[index].city}, ${snapshot.data[index].state}",
                                style: GoogleFonts.getFont('Roboto Slab',
                                    fontSize: 14.sp),
                              ),
                              Text(snapshot.data[index].country,
                                  style: GoogleFonts.getFont('Lora',
                                      fontSize: 14.sp))
                            ],
                          )
                        ]),
                      ),
                    );
                  }),
            );
          } else {
            return Text("Something Went Wrong");
          }
        },
      ),
    );
  }
}
