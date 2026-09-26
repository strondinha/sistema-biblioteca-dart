class Emprestimo {
  String codigo, usuario, livro;
  DateTime inicio, prazo;
  DateTime? devolucao;
  double multa;
  bool ativo;
  Emprestimo(
      {required this.codigo,
      required this.usuario,
      required this.livro,
      required this.inicio,
      required this.prazo,
      this.devolucao,
      this.multa = 0,
      this.ativo = true});
  factory Emprestimo.csv(String l) {
    final p = l.split(';');
    return Emprestimo(
        codigo: p[0],
        usuario: p[1],
        livro: p[2],
        inicio: DateTime.parse(p[3]),
        prazo: DateTime.parse(p[4]),
        devolucao: p[5] == '-' ? null : DateTime.parse(p[5]),
        multa: double.parse(p[6]),
        ativo: p[7] == 'true');
  }
  String csv() =>
      '$codigo;$usuario;$livro;${inicio.toIso8601String()};${prazo.toIso8601String()};${devolucao?.toIso8601String() ?? '-'};${multa.toStringAsFixed(2)};$ativo';
  @override
  String toString() =>
      '$codigo | usuário: $usuario | livro: $livro | prazo: ${prazo.day}/${prazo.month}/${prazo.year} | ${ativo ? 'ativo' : 'devolvido'} | multa: R\$ ${multa.toStringAsFixed(2)}';
}
