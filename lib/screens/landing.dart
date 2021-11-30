import 'dart:convert';
import 'dart:io';

import 'package:cuaca_app/widgets/app_color.dart';
import 'package:cuaca_app/widgets/app_styles.dart';
import 'package:cuaca_app/widgets/app_text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String url = "https://data.bmkg.go.id/DataMKG/MEWS/DigitalForecast/DigitalForecast-Bali.xml";

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://data.bmkg.go.id/DataMKG/MEWS/DigitalForecast/",
      responseType: ResponseType.plain,
      headers: {
        Headers.contentTypeHeader: "application/xml",
      },
    ),
  );

  final _interceptors = InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      return handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      return handler.next(response);
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      return handler.next(e);
    },
  );

  _getData() async {
    try {
      dio.interceptors.add(_interceptors);
      var response = await dio.get('DigitalForecast-Bali.xml');
      print(response);
      
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Hellow Test",
      body: Column(
        children: [
          Text(
            "testt",
            style: AppTextStyle().blueDark16,
          ),
          MaterialButton(
            onPressed: () {
              _getData();
            },
            color: AppColor.orange,
            child: Text(
              "call",
              style: AppTextStyle().blueDark16,
            ),
          ),
        ],
      ),
      context: context,
    );
  }
}