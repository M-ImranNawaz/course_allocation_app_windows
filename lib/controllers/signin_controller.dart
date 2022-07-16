import 'package:course_allocation/database/login_cred_adapter.dart';
import 'package:course_allocation/dialog_helper.dart';
import 'package:course_allocation/main.dart';
import 'package:course_allocation/services/base_client.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import '../views/views.dart';
import 'base_controller.dart';

class SignInPageController extends GetxController with BaseController {
  loginHOD(String email, String password) async {
    BaseClient baseClient = BaseClient();
    showLoading();
    var response = await baseClient.post(kBaseUrl, 'signin',
        {'email': email, 'password': password}).catchError(handleError);
    hideLoading();
    if (response == null) return;
    if (response.toString() == '0') {}
    if (response.toString().contains(email)) {
      // List<String> userDetails = [
      //   response['user']['id'].toString(),
      //   response['user']['name'].toString(),
      //   response['user']['department'].toString(),
      //   response['user']['email'].toString(),
      //   response['token'].toString()
      // ];
      saveCredentials(response, password);
      DialogHelper.showCDialog('Success', 'Account Logged In Successfully', () {
        Navigator.pop(navigatorkey.currentState!.context);
        Navigator.pushReplacement(navigatorkey.currentState!.context,
            FluentPageRoute(builder: (context) => const Home()));
      });
      //navTo(Home(data: lDetails, isSignedIn: true));
    }
  }

  navTo(page) {
    Navigator.push(navigatorkey.currentState!.context,
        FluentPageRoute(builder: (context) => page));
  }

  saveCredentials(response, String password) {
    loginBox.add(LoginCred(
        id: response['user']['id'].toString(),
        name: response['user']['name'].toString(),
        email: response['user']['email'].toString(),
        password: password,
        department: response['user']['department'].toString(),
        isLoggedIn: true,
        token: response['token'].toString()));
  }
}
