class HandleValidationPassword {
  static emptyInput(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'este campo es requerido';
    }
    if (text.trim().length <= 7) {
      return 'debe tener al menos 8 caracteres';
    }
    return null;
  }
}
