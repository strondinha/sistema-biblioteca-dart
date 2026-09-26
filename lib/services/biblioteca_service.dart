import 'dart:io';
import '../models/livro.dart';
import '../models/usuario.dart';
import '../models/emprestimo.dart';
import '../utils/validadores.dart';

class BibliotecaService {
  final dir = 'dados';
  final livros = <Livro>[];
  final usuarios = <Usuario>[];
  final emprestimos = <Emprestimo>[];
  BibliotecaService() {
    Directory(dir).createSync(recursive: true);
    _carregar();
  }
  String _ler(String nome) {
    final f = File('$dir/$nome');
    if (!f.existsSync()) f.writeAsStringSync('');
    return f.readAsStringSync();
  }

  void _carregar() {
    for (final l
        in _ler('livros.txt').split('\n').where((x) => x.trim().isNotEmpty)) {
      try {
        livros.add(Livro.csv(l));
      } catch (_) {}
    }
    for (final l
        in _ler('usuarios.txt').split('\n').where((x) => x.trim().isNotEmpty)) {
      try {
        usuarios.add(Usuario.csv(l));
      } catch (_) {}
    }
    for (final l in _ler('emprestimos.txt')
        .split('\n')
        .where((x) => x.trim().isNotEmpty)) {
      try {
        emprestimos.add(Emprestimo.csv(l));
      } catch (_) {}
    }
  }

  void _salvar(String nome, Iterable<String> linhas) =>
      File('$dir/$nome').writeAsStringSync(linhas.join('\n'));
  Livro? livro(String c) => livros.where((x) => x.codigo == c).firstOrNull;
  Usuario? usuario(String c) =>
      usuarios.where((x) => x.codigo == c).firstOrNull;
  Emprestimo? emprestimo(String c) =>
      emprestimos.where((x) => x.codigo == c).firstOrNull;
  String _p(String texto) {
    stdout.write(texto);
    return stdin.readLineSync() ?? '';
  }

  void cadastrarLivro() {
    try {
      final c = Validadores.texto(_p('Código: '), 'Código');
      if (livro(c) != null) throw FormatException('Código já cadastrado.');
      final l = Livro(
          codigo: c,
          titulo: Validadores.texto(_p('Título: '), 'Título'),
          autor: Validadores.texto(_p('Autor: '), 'Autor'),
          categoria: Validadores.texto(_p('Categoria: '), 'Categoria'),
          ano: Validadores.inteiro(_p('Ano: '), 'Ano', minimo: 1),
          quantidade:
              Validadores.inteiro(_p('Quantidade: '), 'Quantidade', minimo: 1));
      livros.add(l);
      _salvar('livros.txt', livros.map((x) => x.csv()));
      print('Livro cadastrado.');
    } catch (e) {
      print('Erro: $e');
    }
  }

  void listarLivros() {
    if (livros.isEmpty)
      print('Nenhum livro.');
    else
      livros.forEach(print);
  }

  void buscarLivro() {
    final l = livro(_p('Código: '));
    print(l ?? 'Livro não encontrado.');
  }

  void alterarLivro() {
    final l = livro(_p('Código: '));
    if (l == null) {
      print('Não encontrado.');
      return;
    }
    l.titulo = _p('Título [${l.titulo}]: ').trim().isEmpty ? l.titulo : _p('');
  }

  void excluirLivro() {
    final c = _p('Código: ');
    if (emprestimos.any((e) => e.livro == c && e.ativo)) {
      print('Livro emprestado.');
      return;
    }
    livros.removeWhere((x) => x.codigo == c);
    _salvar('livros.txt', livros.map((x) => x.csv()));
    print('Livro excluído.');
  }

  void cadastrarUsuario() {
    try {
      final c = Validadores.texto(_p('Código: '), 'Código');
      if (usuario(c) != null) throw FormatException('Código já cadastrado.');
      final tipo =
          Validadores.texto(_p('Tipo (aluno/professor/comunidade): '), 'Tipo')
              .toLowerCase();
      if (!['aluno', 'professor', 'comunidade'].contains(tipo))
        throw FormatException('Tipo inválido.');
      usuarios.add(Usuario(
          codigo: c,
          nome: Validadores.texto(_p('Nome: '), 'Nome'),
          telefone: Validadores.texto(_p('Telefone: '), 'Telefone'),
          email: Validadores.texto(_p('E-mail: '), 'E-mail'),
          tipo: tipo));
      _salvar('usuarios.txt', usuarios.map((x) => x.csv()));
      print('Usuário cadastrado.');
    } catch (e) {
      print('Erro: $e');
    }
  }

  void listarUsuarios() {
    if (usuarios.isEmpty)
      print('Nenhum usuário.');
    else
      usuarios.forEach(print);
  }

  void alterarUsuario() {
    print('Para alterar, exclua e cadastre novamente.');
  }

  void excluirUsuario() {
    final c = _p('Código: ');
    if (emprestimos.any((e) => e.usuario == c && e.ativo)) {
      print('Usuário possui empréstimo ativo.');
      return;
    }
    usuarios.removeWhere((x) => x.codigo == c);
    _salvar('usuarios.txt', usuarios.map((x) => x.csv()));
    print('Usuário excluído.');
  }

  void registrarEmprestimo() {
    try {
      final c = Validadores.texto(_p('Código do empréstimo: '), 'Código');
      final u = Validadores.texto(_p('Código do usuário: '), 'Usuário');
      final l = Validadores.texto(_p('Código do livro: '), 'Livro');
      final livroAtual = livro(l);
      if (emprestimo(c) != null || usuario(u) == null || livroAtual == null)
        throw FormatException('Código inválido ou cadastro inexistente.');
      if (livroAtual.quantidade < 1 ||
          emprestimos.any((e) => e.usuario == u && e.ativo))
        throw FormatException('Indisponível ou usuário já possui empréstimo.');
      final agora = DateTime.now();
      emprestimos.add(Emprestimo(
          codigo: c,
          usuario: u,
          livro: l,
          inicio: agora,
          prazo: agora.add(const Duration(days: 7))));
      livroAtual.quantidade--;
      _salvar('livros.txt', livros.map((x) => x.csv()));
      _salvar('emprestimos.txt', emprestimos.map((x) => x.csv()));
      print('Empréstimo registrado.');
    } catch (e) {
      print('Erro: $e');
    }
  }

  void devolverLivro() {
    final e = emprestimo(_p('Código do empréstimo: '));
    if (e == null || !e.ativo) {
      print('Empréstimo inválido.');
      return;
    }
    final l = livro(e.livro);
    if (l == null) return;
    final agora = DateTime.now();
    e.multa =
        agora.isAfter(e.prazo) ? agora.difference(e.prazo).inDays * 2.5 : 0;
    e.devolucao = agora;
    e.ativo = false;
    l.quantidade++;
    _salvar('livros.txt', livros.map((x) => x.csv()));
    _salvar('emprestimos.txt', emprestimos.map((x) => x.csv()));
    print('Devolvido. Multa: R\$ ${e.multa.toStringAsFixed(2)}');
  }

  void relatorioAtrasados() {
    final l =
        emprestimos.where((e) => e.ativo && DateTime.now().isAfter(e.prazo));
    if (l.isEmpty)
      print('Nenhum atraso.');
    else
      l.forEach(print);
  }

  void relatorioCategorias() {
    final m = <String, int>{};
    for (final l in livros) m[l.categoria] = (m[l.categoria] ?? 0) + 1;
    m.forEach((k, v) => print('$k: $v livro(s)'));
  }

  void relatorioUsuarios() {
    for (final u in usuarios) {
      final n =
          emprestimos.where((e) => e.usuario == u.codigo && e.ativo).length;
      if (n > 0) print('${u.nome}: $n empréstimo(s)');
    }
  }
}
