import 'package:flutter/material.dart';
import 'package:utilidades/src/controllers/product_controller.dart';
import 'package:utilidades/src/models/product_model.dart';
import 'package:utilidades/src/views/product_form.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _controller = ProductController();
  late Future<List<ProductModel>> _produtos;

  @override
  void initState() {
    super.initState();
    _loadProdutos();
  }

  void _loadProdutos(){
    setState(() {
      _produtos = _controller.fetchProdutos(context);
    });
  }

  void abrirForm({ProductModel? produto}) async{
    final resultado = await showDialog<bool>(
      context: context,
      builder: (_) => ProductForm(produto: produto, controller: _controller)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductModel>>(
        future: _produtos,
        builder: (_, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text("Erro: ${snapshot.error}"),);
          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(child: Text("Nenhum produto encontrado"),);
          }

          final produtos = snapshot.data!;
          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (_, i){
              final p = produtos[i];
              return ListTile(
                title: Text(p.nome),
                subtitle: Text(
                  "Preço: ${p.preco}\nDescrição: ${p.descricao}"
                ),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => abrirForm(produto: p), 
                      icon: Icon(Icons.edit)
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.delete),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => abrirForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}