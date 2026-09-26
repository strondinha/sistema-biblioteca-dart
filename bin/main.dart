import 'dart:io';
import '../lib/services/biblioteca_service.dart';

void main() {
  final sistema = BibliotecaService();
  while (true) {
    print('''
================ SISTEMA DE BIBLIOTECA ================
1 - Cadastrar livro       2 - Listar livros
3 - Buscar livro          4 - Alterar livro
5 - Excluir livro         6 - Cadastrar usuário
7 - Listar usuários       8 - Alterar usuário
9 - Excluir usuário      10 - Registrar empréstimo
11 - Devolver livro       12 - Relatório de atrasados
13 - Relatório por categoria  14 - Usuários com empréstimos
0 - Sair
========================================================''');
    stdout.write('Opção: ');
    final opcao = int.tryParse(stdin.readLineSync() ?? '');
    switch (opcao) {
      case 1:
        sistema.cadastrarLivro();
        break;
      case 2:
        sistema.listarLivros();
        break;
      case 3:
        sistema.buscarLivro();
        break;
      case 4:
        sistema.alterarLivro();
        break;
      case 5:
        sistema.excluirLivro();
        break;
      case 6:
        sistema.cadastrarUsuario();
        break;
      case 7:
        sistema.listarUsuarios();
        break;
      case 8:
        sistema.alterarUsuario();
        break;
      case 9:
        sistema.excluirUsuario();
        break;
      case 10:
        sistema.registrarEmprestimo();
        break;
      case 11:
        sistema.devolverLivro();
        break;
      case 12:
        sistema.relatorioAtrasados();
        break;
      case 13:
        sistema.relatorioCategorias();
        break;
      case 14:
        sistema.relatorioUsuarios();
        break;
      case 0:
        print('Programa encerrado.');
        return;
      default:
        print('Opção inválida.');
    }
  }
}
