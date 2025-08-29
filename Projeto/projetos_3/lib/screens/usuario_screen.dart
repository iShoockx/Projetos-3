import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../services/auth.dart';
import '../models/usuario.dart';
import '../widgets/navbar.dart';
import '../widgets/appbar.dart';

/// Tela de Gerenciamento de Perfil do Usuário
/// 
/// Esta tela permite aos usuários visualizar e editar suas informações pessoais:
/// - Editar nome, e-mail e telefone
/// - Salvar alterações no Firebase Auth e Firestore
/// - Logout seguro da aplicação
/// - Interface responsiva e validada
/// 
/// **Integração:**
/// - Firebase Authentication (dados de autenticação)
/// - Cloud Firestore (dados complementares do perfil)
/// - Serviço personalizado de autenticação (AuthService)
/// 
/// **Funcionalidades:**
/// - Carregamento automático dos dados do usuário
/// - Validação de formulários em tempo real
/// - Atualização simultânea no Auth e Firestore
/// - Feedback visual de operações
/// - Logout com navegação limpa

class UsuarioScreen extends StatefulWidget {
  final AuthService authService;

  const UsuarioScreen({super.key, required this.authService});

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _celularController = TextEditingController();

  bool _loading = false;
  AppUser? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await widget.authService.currentUser;
    if (user != null) {
      setState(() {
        _currentUser = user;
        _nameController.text = user.name;
        _emailController.text = user.email ?? '';
        _celularController.text = user.celular ?? '';
      });
    }
  }

  Future<void> _saveUsuario() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      // Atualiza nome e celular no Firestore
      await widget.authService.updateProfile(
        name: _nameController.text.trim(),
        celular: _celularController.text.trim(),
      );

      // Atualiza email no FirebaseAuth e Firestore
      if (_emailController.text.trim() != _currentUser?.email) {
        await widget.authService.updateEmail(_emailController.text.trim());
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Perfil atualizado com sucesso!')));

      await _loadUser(); // Recarrega dados atualizados
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao atualizar perfil: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _currentUser == null
          ? SingleChildScrollView(
            child: Center(child: CircularProgressIndicator()))
          : Padding(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Nome'),
                      validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (v) => v!.isEmpty ? 'Informe o email' : null,
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _celularController,
                      decoration: InputDecoration(labelText: 'Celular'),
                    ),
                    SizedBox(height: 32.h),
                    _loading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _saveUsuario,
                            child: Text('Salvar alterações'),
                          ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 247, 36, 0),
                        minimumSize: Size(150.w, 40.h),
                      ),
                      onPressed: () async {
                        await widget.authService.signOut();
                        if (context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        }
                      },
                      child: Text('Sair'
                          , style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: const Navbar(currentRoute: "/usuario"),
    );
  }
}
