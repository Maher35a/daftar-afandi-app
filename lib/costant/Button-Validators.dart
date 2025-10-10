class Validators {
  static String? validateName(String value) {
    if (value.trim().isEmpty) {
      return "الاسم مطلوب";
    }
    return null;
  }

  static String? validateAmount(String value) {
    if (value.trim().isEmpty) {
      return "المبلغ مطلوب";
    }
    if (double.tryParse(value) == null) {
      return "المبلغ يجب أن يكون رقم";
    }
    return null;
  }
}
