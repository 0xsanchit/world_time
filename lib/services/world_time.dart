import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time;
  String flag;
  String url;
  bool isDaytime=true;

  WorldTime({this.location,this.flag,this.url});

  // ignore: empty_constructor_bodies
  Future<void> getTime()
  async {

    try{
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);
      String offset1 = data['utc_offset'].substring(0,1)+data['utc_offset'].substring(4,6);
      //print(datetime);
      //print(offset);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset),minutes: int.parse(offset1)));
      //print(now);

      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 6 && now.hour < 20 ? true:false;
    }
    catch(e){
      print('caught error: $e');
      time = 'could not get time data';
    }

  }
}
