import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:food_delivery/common/globs.dart';
import 'package:food_delivery/common/locator.dart';
import 'package:http/http.dart' as http;

typedef ResSuccess = Future<void> Function(Map<String, dynamic>);
typedef ResFailure = Future<void> Function(dynamic);

class ServiceCall {
  static final NavigationService navigationService = locator<NavigationService>();
  static Map userPayload = {};


  static void post(Map<String, dynamic> parameter, String path,
      {bool isToken = false, ResSuccess? withSuccess, ResFailure? failure}) {
    Future(() {
      try {
       var headers = {'Content-Type': 'application/json'};

        // if(isToken) {
        //   headers["token"] = "";
        // }

        http
            .post(Uri.parse(path), body: jsonEncode(parameter), headers: headers,)
            .then((value) {
          if (kDebugMode) {
            print(value.body);
          }
          final body = value.body.trim();
          if (body.isEmpty) {
            if (withSuccess != null) withSuccess(<String, dynamic>{});
            return;
          }

          try {
            final decoded = json.decode(body);
            if (decoded is Map<String, dynamic>) {
              if (withSuccess != null) withSuccess(decoded);
            } else {
              if (failure != null) {
                final snippet = body.length > 200 ? body.substring(0, 200) : body;
                failure('Invalid response format (expected JSON object). Snippet: $snippet');
              }
            }
          } catch (err) {
            if (failure != null) {
              final snippet = body.length > 200 ? body.substring(0, 200) : body;
              failure('Failed to parse JSON response. Snippet: $snippet. Error: $err');
            }
          }
        }).catchError( (e) {
           if (failure != null) failure(e.toString());
        });
      } catch (err) {
        if (failure != null) failure(err.toString());
      }
    });
  }

  static logout(){
    Globs.udBoolSet(false, Globs.userLogin);
    userPayload = {};
    navigationService.navigateTo("welcome");
  }


}
