import 'dart:io';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:rolo/secureStorage.dart';
import 'package:url_launcher/url_launcher.dart';

const _clientId =
    "733862104430-efpd1frld9mcduj76ph7v49cgmg0aca1.apps.googleusercontent.com";
const _clientSecret = "iyv9cU0B14LfrRPsAC32AQLd";

const _scopes = [ga.DriveApi.DriveFileScope];

class GoogleDrive {
//get auth client

  final storage = SecureStorage();

  Future<http.Client> getHttpClient() async {
    var credentials = await storage.getCredentials();
    if (credentials == null) {
      var authClient = await clientViaUserConsent(
          ClientId(_clientId, _clientSecret), _scopes, (url) {
        launch(url, forceSafariVC: false, forceWebView: false);
      });
      return authClient;
    } else {
      return authenticatedClient(
        http.Client(),
        AccessCredentials(
            AccessToken(credentials["type"], credentials["data"],
                DateTime.parse(credentials["expiry"])),
            credentials['refreshToken'],
            _scopes),
      );
    }
  }

  //upload file
  Future upload(File file) async {
    var client = await getHttpClient();
    var drive = ga.DriveApi(client);

    var response = await drive.files.create(
        ga.File()..name = p.basename(file.absolute.path),
        uploadMedia: ga.Media(file.openRead(), file.lengthSync()));

    print(response.toJson());
  }
}
