import 'package:clean_architecture_cubit/shared/dialogs/error_dialog.dart';

class Helper {
  static String handleError(int status, String message) {
    switch (status) {
      case 401:
        ErrorDialog.unauthorizedError();
        return message;
      default:
        return message;
    }
  }
}
