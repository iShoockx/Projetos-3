import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrarScreen extends StatefulWidget {
  const RegistrarScreen({Key? key}) : super(key: key);

  @override
  State<RegistrarScreen> createState() => _RegistrarScreenState(); // necessario para StatefulWidget criação de estado
}

class _RegistrarScreenState extends State<RegistrarScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave para o formulário
  bool _obscure = true; // Variável para esconder a senha

  final TextEditingController _emailController =
      TextEditingController(); // Controlador para o campo de email
  final TextEditingController _passwordController =
      TextEditingController(); // Controlador para o campo
  final TextEditingController _confirmPasswordController =
      TextEditingController(); // Controlador para o campo de confirmação de senha

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold é o layout básico do Material Design
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Tec Frio',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(width: 5.w),
            const Icon(Icons.ac_unit, color: Colors.blue),
          ],
        ),
      ),
      body: Padding(
        // Corpo do texto
        padding: EdgeInsets.symmetric(horizontal: 24.w),

        //Formulário de registro
        child: Form(
          key: _formKey,
          child: Column(
            // Coluna para organizar os widgets verticalmente
            mainAxisAlignment:
                MainAxisAlignment.center, // Centraliza verticalmente
            children: [
              // Comando para adicionar widgets
              TextFormField(
                controller: _emailController,
                // Campo de texto para o usuário
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextFormField(
                // campo de texto para a senha
                controller: _passwordController,

                obscureText: _obscure, // Esconde o texto digitado
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextFormField(
                // campo de texto para a senha
                controller: _confirmPasswordController,

                obscureText: _obscure, // Esconde o texto digitado
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              ElevatedButton(
                onPressed: () {
                  //função para lidar com as informações do forms
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 6,
                  shadowColor: Colors.black.withOpacity(0.2),
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
