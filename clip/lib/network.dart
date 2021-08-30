import 'dart:convert';
import 'package:clip/model.dart';
import 'package:http/http.dart' as http;

// String host = "http://localhost:8000/api/";
String host = "http://168.188.125.209:8080/api/";

class Sign {
  List<User> parseUser(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJSON(json)).toList();
  }

  Future signUp(Map data, String path) async {
    String url = "$host${path}/";
    try {
      var body = json.encode(data);
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: body);
      if (response.statusCode == 201) {
        return User.fromJSON(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        return response.statusCode;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signIn(Map data, String path) async {
    String url = "$host${path}/";
    try {
      var body = json.encode(data);
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: body);
      if (response.statusCode == 200) {
        return User.fromJSON(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        return response.statusCode;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class HCILocation {


  Future getScreen(String X, String Y, String uid, String description, String path) async {

    Map data = {
      "x": Y,
      "y": X,
      "uid": uid,
      "description": description
    };

    String url = "$host${path}/";
    try {
      var body = json.encode(data);
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: body);
      if (response.statusCode == 201) {
        return User.fromJSON(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        return response.statusCode;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

// Future signIn(Map data, String path) async {
//   String url = "$host${path}/";
//   try {
//     var body = json.encode(data);
//     final response = await http.post(Uri.parse(url),
//         headers: {
//           'Content-type': 'application/json',
//           'Accept': 'application/json',
//         },
//         body: body);
//     if (response.statusCode == 200) {
//       return User.fromJSON(jsonDecode(response.body));
//     } else if (response.statusCode == 400) {
//       return response.statusCode;
//     }
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }
}

