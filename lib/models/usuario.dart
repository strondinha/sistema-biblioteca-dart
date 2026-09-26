class Usuario {
  String codigo, nome, telefone, email, tipo;
  Usuario({required this.codigo, required this.nome, required this.telefone, required this.email, required this.tipo});
  factory Usuario.csv(String l) { final p=l.split(';'); return Usuario(codigo:p[0], nome:p[1], telefone:p[2], email:p[3], tipo:p[4]); }
  String csv() => '$codigo;$nome;$telefone;$email;$tipo';
  @override String toString() => '$codigo | $nome | $telefone | $email | $tipo';
}
