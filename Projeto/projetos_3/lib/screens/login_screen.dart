import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  bool cadastro = false; // Variável para controlar o estado do cadastro

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          //elemento Forms com os campos de login
          key: _formKey, //chave do forms
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  //campo de forms para o emailw
                  controller:
                      _emailController, //linka o campo com o controller para registrar as alterações
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  // validator: (value) {
                  //   //lida com as informações dos campos para validar suas informações
                  //   if (value == null || value.isEmpty) {
                  //     return 'Por favor, insira seu e-mail';
                  //   }
                  //   if (!value.contains('@')) {
                  //     return 'E-mail inválido';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  //campo do forms para a senha
                  controller:
                      _passwordController, //linka o campo com o controller para registrar as alterações
                  obscureText: _obscure,
            
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
                  // validator: (value) {
                  //   //lida com as informações dos campos para validar suas informações
                  //   if (value == null || value.isEmpty) {
                  //     return 'Por favor, insira sua senha';
                  //   }
                  //   if (value.length < 6) {
                  //     return 'A senha deve ter pelo menos 6 caracteres';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: 10.h),
                Visibility(
                  visible: cadastro,
                  child: Column(
                    children: [
                      TextFormField(
                        //campo do forms para a confirmação de senha
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          labelText: 'Confirmar Senha',
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
                      TextFormField(
                        //campo de forms para o email
                        controller:
                            _nameController, //linka o campo com o controller para registrar as alterações
                        decoration: const InputDecoration(
                          labelText: 'nome',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // Alterna o estado do cadastro
                      setState(() {
                        cadastro = !cadastro;
                      });
                    },
                    child: const Text('Criar conta'),
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
                  child: Text((cadastro) ? 'Entrar' : 'Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
