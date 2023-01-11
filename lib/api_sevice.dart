import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trainee_links_apk/config.dart';
import 'package:trainee_links_apk/models/link_model.dart';

class APIService {
  static var client = http.Client();

  static Future<List<LinkModel>?> getLinks() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.linkURL);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return linksFromJson(data["data"]);
    } else {
      return null;
    }
  }

  static Future<List<LinkModel>?> saveBilhete(
    LinkModel model,
    bool isEditMode,
  ) async {
    var linkURL = Config.linkURL;

    if (isEditMode) {
      linkURL = "$linkURL/${model.linkId}";
    }

    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, linkURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["bilheteOdds"] = model.linkTitle!;
    request.fields["bilheteEntrada"] = model.linkTitle!;

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return linksFromJson(data["data"]);
    } else {
      return null;
    }
  }
}