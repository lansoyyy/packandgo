bool isValidEmail(String email) {
  String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(emailPattern);
  return regex.hasMatch(email);
}
