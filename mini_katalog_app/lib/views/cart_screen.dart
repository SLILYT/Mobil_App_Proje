import 'package:flutter/material.dart';
import 'package:mini_katalog_app/model/products_model.dart';

class CartScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> cartIds;

  const CartScreen({super.key, required this.products, required this.cartIds});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products
        .where((product) => widget.cartIds.contains(product.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sepetim"),
        backgroundColor: Colors.white,
        leadingWidth: 20,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: cartProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),

                            SizedBox(height: 12),

                            Text(
                              "Sepetiniz boş",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(height: 12),

                            Text(
                              "Başlamak için ürün ekleyin",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final item = cartProducts[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(item.image ?? ""),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 16),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name ?? "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(item.tagline ?? ""),

                                      Text(item.price ?? ""),
                                    ],
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.cartIds.remove(item.id);
                                    });
                                  },
                                  icon: Icon(Icons.remove_circle_outline),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey.shade500),

                    SizedBox(width: 8),

                    Text(
                      "Sepetinizde ${cartProducts.length} ürün var",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size.fromHeight(50),
                ),
                child: Text("Ödeme Yap", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
