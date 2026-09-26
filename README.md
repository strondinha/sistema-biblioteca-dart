# Sistema de Biblioteca em Dart

Sistema de gestão de biblioteca desenvolvido em Dart para o trabalho final da disciplina de Algoritmos e Lógica de Programação.

## Objetivo

O sistema foi criado para gerenciar:
- cadastro de livros
- cadastro de usuários
- empréstimos de livros
- devoluções de livros
- cálculo de multa por atraso
- relatórios e consultas
- persistência em arquivos TXT

## Requisitos atendidos

- Menu principal com repetição até a saída do sistema
- CRUD completo de livros
- CRUD completo de usuários
- Validação de entradas do usuário
- Controle de empréstimos e devoluções
- Regra de negócio para multa por atraso
- Relatórios com filtro e consulta
- Organização por classes e funções
- Uso de listas, mapas e manipulação de datas

## Estrutura do projeto

```text
sistema_biblioteca_dart/
├── README.md
├── pubspec.yaml
├── bin/
│   └── main.dart
├── lib/
│   ├── models/
│   │   ├── livro.dart
│   │   ├── usuario.dart
│   │   └── emprestimo.dart
│   ├── services/
│   │   └── biblioteca_service.dart
│   └── utils/
│       └── validadores.dart
└── dados/
    ├── livros.txt
    ├── usuarios.txt
    └── emprestimos.txt
```

## Como executar

1. Abra o terminal no diretório do projeto.
2. Verifique se o Dart SDK está instalado no computador.
3. Execute os comandos abaixo:

```bash
git clone https://github.com/strondinha/sistema-biblioteca-dart.git
cd sistema-biblioteca-dart
dart pub get
dart run bin/main.dart
```

## Funcionalidades do sistema

### 1. Cadastro de livros
- Cadastrar livro com código, título, autor, categoria, ano e quantidade.
- Validação para impedir campos vazios e valores inválidos.

### 2. Cadastro de usuários
- Cadastrar usuário com código, nome, telefone, e-mail e tipo.
- Tipos aceitos: aluno, professor e comunidade.

### 3. Empréstimo
- Registrar empréstimo entre usuário e livro.
- O livro só pode ser emprestado se estiver disponível.
- Cada usuário pode ter somente um empréstimo ativo.
- O empréstimo possui prazo de 7 dias.

### 4. Devolução
- Registrar a devolução do livro.
- Caso a entrega seja após o prazo, calcula-se multa por dia de atraso.

### 5. Relatórios
- Listar livros em atraso
- Mostrar livros por categoria
- Mostrar usuários com empréstimos ativos

## Persistência

Os dados são armazenados em arquivos TXT dentro da pasta `dados`:
- `livros.txt`
- `usuarios.txt`
- `emprestimos.txt`

## Observações

Este projeto foi desenvolvido como solução acadêmica para o tema de biblioteca do trabalho final. O foco está em praticar conceitos fundamentais de programação, organização de código e lógica de negócios.

## Autor

Caio Vieira Vila Nova