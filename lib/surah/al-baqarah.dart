import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Albaqarah extends StatefulWidget {
  @override
  _AlbaqarahState createState() => _AlbaqarahState();
}

class _AlbaqarahState extends State<Albaqarah> {
  List data;
  Future<Map> Ambildata() async {
    var url = 'http://api.alquran.cloud/v1/quran/quran-uthmani';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        data = jsonResponse['data']['surahs'][1]['ayahs'];
      });
      print(jsonResponse['data']['surahs'][1]['ayahs']);
    } else {
      print('gagal');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Ambildata();
  }

  Widget widgett(item) => Container(
        child: ListTile(
          leading: Text(item['numberInSurah'].toString()),
          title: Text(item['text']),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Al-baqarah'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 17,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (ctx, i) {
            return widgett(data[i]);
          }),
    );
  }
}
