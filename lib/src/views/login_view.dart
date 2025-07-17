import 'package:flutter/material.dart';
import 'package:utilidades/src/controllers/login_controller.dart';
import 'package:utilidades/src/models/user_model.dart';
import 'package:utilidades/src/services/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = LoginController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = '';
  bool _isLoading = false;
  
/*   void _handleLogin() async{
    final success = await _controller.login(
      _usernameController.text,
      _passwordController.text
    );

    if(success){
      AuthService.login();
      Navigator.pushReplacementNamed(context, "/home");
    }else{
      setState(() {
        _message = "Usuário ou senha incorretos";
      });
    }
  } */
 void _handleLogin() async{
  setState(() {
    _isLoading = true;
  });

  final user = UserModel(
    username : _usernameController.text.trim(),
    password : _passwordController.text.trim()
  );

  final success = await _controller.login(user);

  setState(() {
    _isLoading = false;
  });

  if(success){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Login efetuado com sucesso"))
    );

    Navigator.pushReplacementNamed(context, '/home');
  }else{
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Dados de login incorretos"))
    );
  }
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Image.asset("assets/images/utility.png", width: 200,),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Usuário",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Senha",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
              obscureText: true,
            ),
            SizedBox(height: 10,),
            _isLoading ?
            const CircularProgressIndicator() : 
            
            ElevatedButton(
              onPressed: _handleLogin, 
              child: Text("entrar")
            ),
            SizedBox(height: 10,),
            Text(_message, style: TextStyle(color: Colors.red),)
          ],
        ),
      ),
    );
  }
}