import 'dart:io';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:rolo/secureStorage.dart';

import 'package:url_launcher/url_launcher.dart';

const _clientId =
    "440791410873-7q901q6sml3hr6qf6qi0q8cis3nb27ng.apps.googleusercontent.com";
const _clientSecret = "u_eqgeHLzKAVDaXrG0-BftN5";

const _scopes = [ga.DriveApi.DriveFileScope];

class GoogleDrive {
//get auth client

  final storage = SecureStorage();

  Future<http.Client> getHttpClient() async {
    var credentials = await storage.getCredentials();

    if (credentials == null) {
      var authClient = await clientViaUserConsent(
          ClientId(_clientId, _clientSecret), _scopes, (url) {
        launch(url,
            forceSafariVC: false,
            forceWebView: false,
            headers: <String, String>{'header_key': 'header_value'});
      });
      await storage.saveCredentials(authClient.credentials.accessToken,
          authClient.credentials.refreshToken);
      return authClient;
    } else {
      return authenticatedClient(
        http.Client(),
        AccessCredentials(
            AccessToken(credentials["type"], credentials["data"],
                DateTime.tryParse(credentials["expiry"])),
            credentials["refreshToken"],
            _scopes),
      );
    }
  }

  Future delete(id) async {
    try {
      var client = await getHttpClient();
      var drive = ga.DriveApi(client);

      var response = await drive.files.delete(id);
    } catch (e) {
      storage.clear();
    }
  }

  //upload file
  Future upload(File file) async {
    try {
      var client = await getHttpClient();
      var drive = ga.DriveApi(client);

      var response = await drive.files.create(
          ga.File()..name = p.basename(file.absolute.path),
          uploadMedia: ga.Media(file.openRead(), file.lengthSync()));

      return response.toJson();
    } catch (e) {
      storage.clear();
    }
  }
}
