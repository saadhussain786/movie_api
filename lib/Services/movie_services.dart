import 'package:http/http.dart' as http;
class MovieApi
{
  static Future<dynamic> MovieFetch(int num) async
  {
    var request = http.Request('GET', Uri.parse('https://www.episodate.com/api/most-popular?page=$num'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var res=await response.stream.bytesToString();
     return res;
    }
    else {

      var res1=response.reasonPhrase;
      return res1;
    }
  }

  static Future<dynamic> MovieDescription(int id) async
  {
    var request = http.Request('GET', Uri.parse('https://www.episodate.com/api/show-details?q=$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res=await response.stream.bytesToString();
      return res;
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
