import 'package:fe/surah/al-baqarah.dart';
import 'package:fe/surah/al-fatihah.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Main(),
    initialRoute: 'home',
    routes: {
      'home': (context) => Main(),
      '1': (context) => Alfatihah(),
      '2': (context) => Albaqarah(),
    },
  ));
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Ambildata();
  }

  List data;
  Future<Map> Ambildata() async {
    var url = 'http://api.alquran.cloud/v1/surah';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        data = jsonResponse['data'];
      });
      print(jsonResponse['data']);
    } else {
      print('gagal');
    }
  }

  Widget widgett(item) => Container(
        child: ListTile(
          leading: Text(item['number'].toString()),
          title: Text(item['name']),
          subtitle: Text(item['englishName']),
          trailing: Text(item['numberOfAyahs'].toString()),
          onTap: () {
            setState(() {
              if (item['number'] == 1) {
                Navigator.pushNamed(context, '1');
              } else if (item['number'] == 2) {
                Navigator.pushNamed(context, '2');
              } else {
                print('error');
              }
            });
          },
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Al-Quran'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (ctx, i) {
            return widgett(data[i]);
          }),
    );
  }
}
