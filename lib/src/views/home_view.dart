import 'package:flutter/material.dart';
import 'package:utilidades/src/services/auth_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: ListView(
        children: [
          Text(
            "Aplicativo de estudos Flutter",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Text(
            "Este é um aplicativo de estudos feito com Flutter."
            "Nosso objetivo é entender como funciona a construção de apps usando"
            "o padrão MVC, rotas nomeadas, widgets personalizados, chamadas HTTP e muito mais.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20,),
          Text(
            "O que é Flutter?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10,),
          Text(
            "Flutter é um framework UI open-source criado pelo Google para a criação  de aplicações nativas para Android, iOS, Web e Desktop a partir de uma única base de código. Ele utiliza a linguagem Dart e permite desempenho nativo com renderização própria.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10,),
          Text(
            "Vamos continuar aprendendo tudo sobre Flutter?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )

        ],
      ),
    );
  }
}