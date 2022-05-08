import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ShoppingList(
      products: [
        Product(name: 'Eggs'),
        Product(name: 'Flour'),
        Product(name: 'Chocolate chips'),
      ],
    ),
  ));
}

class Product {
  const Product({required this.name, Key? key});

  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // ツリーの異なる部分が異なるテーマを持つことができるため、
    // テーマはBuildContextに依存します。
    // BuildContext は、ビルドがどこで行われるかを示すので、
    // どのテーマを使うかを決めます。
    return inCart //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class ShoppingList extends StatefulWidget {
  const ShoppingList({required this.products, Key? key}) : super(key: key);

  final List<Product> products;

  // フレームワークは、ツリーの指定された場所にウィジェットが初めて現れたときに、
  // createState を呼び出します。
  // 親が再構築され、同じタイプのウィジェット(同じキー)を使用する場合、
  // フレームワークは、新しい State オブジェクトを作成する代わりに、
  // State オブジェクトを再利用します。
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _shoppingCart = <Product>{};

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      // ユーザーがカートの中身を変更したら、
      // setState 呼び出しの中で _shoppingCart を変更し、
      // 再構築をトリガーする必要があります。
      // その後、フレームワークは以下のように build を呼び出し、
      // アプリの外観を更新します。
      if (inCart) {
        _shoppingCart.remove(product);
      } else {
        _shoppingCart.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}
