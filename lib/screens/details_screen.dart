import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen(
      {this.name,
      this.icao,
      this.city,
      this.country,
      this.lat,
      this.lon,
      this.state,
      this.tz});

  final String? name;
  final String? icao;
  final String? city;
  final String? state;
  final String? country;
  final String? tz;
  final double? lat;
  final double? lon;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Set<Marker> _markers = {};
  int id = 0;

  incrementInt() {
    id = id++;
  }

  @override
  void initState() {
    super.initState();
    incrementInt();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(id.toString()),
          position: LatLng(widget.lat!.toDouble(), widget.lon!.toDouble()),
          infoWindow: InfoWindow(
              title: "Name - ${widget.name}",
              snippet:
                  "Location -: ${widget.city}, ${widget.state}, ${widget.country}")));
    });
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: double.infinity,
              child: GoogleMap(
                markers: _markers,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(widget.lat!.toDouble(), widget.lon!.toDouble()),
                  zoom: 10,
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.amber,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name - ${widget.name}",
                    style: GoogleFonts.getFont('Merriweather', fontSize: 15.sp),
                  ),
                  Text(
                    "ICAO - ${widget.icao}",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1.h,
              color: Colors.amber,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "City - ${widget.city}",
                    style: GoogleFonts.getFont('Merriweather', fontSize: 15.sp),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    "State - ${widget.state}",
                    style: GoogleFonts.getFont('Merriweather', fontSize: 15.sp),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Colors.amber,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Country - ${widget.country}",
                  style: GoogleFonts.getFont('Merriweather', fontSize: 15.sp)),
            ),
            Divider(
              height: 1,
              color: Colors.amber,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("TZ - ${widget.tz}",
                  style: GoogleFonts.getFont('Merriweather', fontSize: 15.sp)),
            ),
            Divider(
              height: 1,
              color: Colors.amber,
              thickness: 2,
            ),
          ],
        ));
  }
}
