import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Usuário',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TelaCadastro(),
    );
  }
}

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // 1. Chave global para controlar a validação do formulário
  final _formKey = GlobalKey<FormState>();

  // 2. Controladores para pegar o texto digitado
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController = TextEditingController();

  // Variável do desafio extra: alternar visibilidade da senha
  bool _mostrarSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding ao redor do formulário
        child: Form(
          key: _formKey, // Estrutura obrigatória
          child: SingleChildScrollView( // Evita erro de estouro de tela com o tecladow
            child: Column(
              children: [
                // CAMPO NOME COMPLETE
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, informe seu nome completo.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), // Espaçamento entre os campos

                // CAMPO E-MAIL
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'O e-mail é obrigatório.';
                    }
                    // Validação simples do @ exigida no roteiro
                    if (!value.contains('@')) {
                      return 'O e-mail deve conter o caractere @.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // CAMPO CPF
                TextFormField(
                  keyboardType: TextInputType.number,
                  // Permite APENAS digitação de números
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'CPF',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'O CPF é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // CAMPO TELEFONE
                TextFormField(
                  keyboardType: TextInputType.number,
                  // Permite APENAS digitação de números
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'O telefone é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // CAMPO SENHA
                TextFormField(
                  controller: _senhaController,
                  obscureText: !_mostrarSenha, // Esconde ou mostra o texto
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _mostrarSenha ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _mostrarSenha = !_mostrarSenha;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A senha é obrigatória.';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter no mínimo 6 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // CAMPO CONFIRMAÇÃO DE SENHA (Desafio Extra)
                TextFormField(
                  controller: _confirmaSenhaController,
                  obscureText: !_mostrarSenha,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != _senhaController.text) {
                      return 'As senhas não coincidem.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // BOTÃO CADASTRAR
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    // Valida todos os campos do formulário
                    if (_formKey.currentState!.validate()) {
                      // Sucesso! Mostra SnackBar Verde
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cadastro realizado com sucesso!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      // Erro! Mostra SnackBar Vermelho (Desafio Extra)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, corrija os erros no formulário.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('CADASTRAR'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}