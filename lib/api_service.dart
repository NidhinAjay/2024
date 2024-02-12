import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:developer' as devLog;
import 'package:http/http.dart' as http;
import 'package:spotify_clone/music_data_response.dart';

class musicapi {
  Future<List<MusicDataResponse>>musicfunction() async {
    const url='https://storage.googleapis.com/uamp/catalog.json';
    Uri uri=Uri.parse(url);
    try{
      final response=await http.get(uri);
      if (response.statusCode==200){
        final body=response.body;
        final json=jsonDecode(body);
        final result=json['music'] as List<dynamic>;
        final musiclist=result.map((e){
          return MusicDataResponse.fromJson(e);
        }
        ).toList();
        debugPrint(response.body.toString());
        devLog.log(musiclist.toString(),name:"My Music Data");
        return musiclist;
      }
      else{
        return throw('Failed to fetch data');
      }
    }
    catch(e){
      print(e);
      return throw('Failed to fetch data');
    }
  }
}