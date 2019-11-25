import 'package:flutter/widgets.dart';

class Auth with ChangeNotifier {
  // String _token;
  // DateTime _expiryDate;
  // String _userId;

  // Future<void> logIn(String email, String password) async {
  //   const url =
  //       "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBYuG5Du7saADhNHpirtfSLgokvZ95R_o4";

  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode(
  //         {
  //           'email': email,
  //           'password': password,
  //           'returnSecureToken': true,
  //         },
  //       ),
  //     );
  //     final responseData = json.decode(response.body);
  //     if (responseData['error'] != null) {
  //       throw HttpException(responseData['error']['message']);
  //     }
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future<bool> logIn(String email, String password) async {
    bool auth(String email, String password) {
      if (email == 'rodolfokawabata@gmail.com' && password == 'rolo1805') {
        return true;
      } else {
        return false;
      }
    }

    bool result;

    return result = await auth(email, password);
  }
}
