class Validadores {
  static String texto(String? valor, String campo) {
    if (valor == null || valor.trim().isEmpty)
      throw FormatException('$campo é obrigatório.');
    if (valor.contains(';'))
      throw FormatException('$campo não pode conter ponto e vírgula.');
    return valor.trim();
  }

  static int inteiro(String? valor, String campo, {int minimo = 0}) {
    final numero = int.tryParse((valor ?? '').trim());
    if (numero == null || numero < minimo)
      throw FormatException('$campo inválido. Mínimo: $minimo.');
    return numero;
  }
}
