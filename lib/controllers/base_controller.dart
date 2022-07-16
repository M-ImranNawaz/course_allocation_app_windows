import '../dialog_helper.dart';
import '../services/app_exceptions.dart';

class BaseController {
  void handleError(error) {
    hideLoading();
    if (error is BadRequestException) {
      DialogHelper.showErrorDialog(description: error.message);
    } else if (error is FetchDataException) {
      DialogHelper.showErrorDialog(description: error.message);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.showErrorDialog(
          description: 'Oops! It took too long to respond');
    } else if (error is UnAutthorizedException) {
      DialogHelper.showErrorDialog(description: error.message);
    }
    else if (error is DataDeletedException) {
      DialogHelper.showErrorDialog(description: error.message);
    }
  }

  showLoading({message = 'Loading Please Wait...'}) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }
}
