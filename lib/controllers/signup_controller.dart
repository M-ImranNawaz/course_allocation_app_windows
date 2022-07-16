import 'package:course_allocation/controllers/base_controller.dart';
import 'package:course_allocation/services/base_client.dart';
import 'package:course_allocation/contstants.dart';
import 'package:get/get.dart';

import '../dialog_helper.dart';
import '../models/hod.dart';

class SignUpPageController extends GetxController with BaseController {
  registerHOD(HOD hod) async {
    showLoading();
    BaseClient baseClient = BaseClient();
    var response = await baseClient.post(kBaseUrl, 'register', hod.toMap()).catchError(handleError);
    hideLoading();
    if (response == null) return;
    DialogHelper.showErrorDialog(
          title: 'Success', description: 'Account Registered Successfully');
    return response;
  }
}
