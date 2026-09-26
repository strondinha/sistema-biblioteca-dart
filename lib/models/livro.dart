class Livro {
  String codigo, titulo, autor, categoria;
  int ano, quantidade;
  Livro(
      {required this.codigo,
      required this.titulo,
      required this.autor,
      required this.categoria,
      required this.ano,
      required this.quantidade});
  factory Livro.csv(String l) {
    final p = l.split(';');
    return Livro(
        codigo: p[0],
        titulo: p[1],
        autor: p[2],
        categoria: p[3],
        ano: int.parse(p[4]),
        quantidade: int.parse(p[5]));
  }
  String csv() => '$codigo;$titulo;$autor;$categoria;$ano;$quantidade';
  @override
  String toString() =>
      '$codigo | $titulo | $autor | $categoria | $ano | exemplares: $quantidade';
}
