void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: '/home',
      initialRoute: '/',
      routes: {
        '/': (context) => const Loading(),
        '/home': (context) => const Home(),
        '/location': (context) => const ChooseLocation(),
      },
    ));

Loading.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_lab/services/world_time.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getTime() async {
    final response = await get(
        Uri.parse("http://worldtimeapi.org/api/timezone/Asia/Kolkata"));
    print(response.body);

    Map timeData = jsonDecode(response.body);
    print(timeData);
    String dateTime = timeData['datetime'];
    String offset = timeData['utc_offset'];

    print(dateTime);
    print(offset);
    DateTime currentTime = DateTime.parse(dateTime);
    print(currentTime);

    String offsetHours = offset.substring(1, 3);
    print(offsetHours);
    String offsetMinutes = offset.substring(4, 6);
    print(offsetMinutes);

    currentTime = currentTime.add(Duration(
        minutes: int.parse(offsetMinutes), hours: int.parse(offsetHours)));

    print(currentTime);
  }

  void setWorldTime() async {
    WordTime timeInstance =
    WordTime(location: 'kolkata', flag: 'india.png', url: 'Asia/Kolkata');
    await timeInstance.getTime();

    // Navigator.pushNamed(context, '/home',arguments: {
    //   'location' : timeInstance.location,
    //   'flag' : timeInstance.flag,
    //   'time' : timeInstance.time
    // });
  }

  @override
  void initState() {
    super.initState();
    setWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //
      //   backgroundColor: Colors.deepPurple,
      //   title: const Text('World Time'),
      //   centerTitle: true,
      // ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       IconButton(
      //           onPressed: () {},
      //           icon: const Icon(
      //             Icons.alarm,
      //             color: Colors.deepPurple,
      //             size: 40,
      //           )),
      //       const Text("Time for your location",
      //           style: TextStyle(fontSize: 20, letterSpacing: 2)),
      //       TextButton(
      //         child:const SpinKitRotatingCircle(
      //           color: Colors.white,
      //           size: 50.0,
      //         ),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
      backgroundColor: Colors.black,
      body:Center(

        child: SpinKitPouringHourGlass (

          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
