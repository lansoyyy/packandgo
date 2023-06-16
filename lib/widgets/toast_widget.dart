import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showToast(msg, {toastLength = Toast.LENGTH_SHORT}) {
  return Fluttertoast.showToast(
    toastLength: toastLength,
    msg: msg,
  );
}
