class Check{
  static bool isDigit(String s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }
}