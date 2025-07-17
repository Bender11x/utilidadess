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

  void _loadProdutos() {
    setState(() {
      _produtos = _controller.fetchProdutos(context);
    });
  }

  void abrirForm({ProductModel? produto}) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (_) => ProductForm(produto: produto, controller: _controller),
    );

    if (resultado == true) {
      _loadProdutos(); // Atualiza a lista ao voltar do form
    }
  }

  void _excluirProduto(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirme a exclusão"),
        content: const Text("Tem certeza que deseja excluir?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirmar"),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await _controller.deletarProduto(id);
      _loadProdutos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductModel>>(
        future: _produtos,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum produto encontrado"));
          }

          final produtos = snapshot.data!;
          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (_, i) {
              final p = produtos[i];
              return ListTile(
                title: Text(p.nome),
                subtitle: Text("Preço: ${p.preco}\nDescrição: ${p.descricao}"),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => abrirForm(produto: p),
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () => _excluirProduto(p.id!),
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => abrirForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
