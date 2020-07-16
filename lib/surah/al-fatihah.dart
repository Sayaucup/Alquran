import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Alfatihah extends StatefulWidget {
  @override
  _AlfatihahState createState() => _AlfatihahState();
}

class _AlfatihahState extends State<Alfatihah> {
  List data;
  Future<Map> Ambildata() async {
    var url = 'http://api.alquran.cloud/v1/quran/quran-uthmani';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        data = jsonResponse['data']['surahs'][0]['ayahs'];
      });
      print(jsonResponse['data']['surahs'][0]['ayahs']);
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
        title: Text('Al-fatihah'),
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
