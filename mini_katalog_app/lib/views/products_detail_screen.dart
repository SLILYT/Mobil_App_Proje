import 'package:flutter/material.dart';
import 'package:mini_katalog_app/model/products_model.dart';

class ProductsDetailScreen extends StatefulWidget {
  final Data product;
  final Set<int> cartIds;

  const ProductsDetailScreen({
    super.key,
    required this.product,
    required this.cartIds,
  });

  @override
  State<ProductsDetailScreen> createState() => _ProductsDetailScreenState();
}

class _ProductsDetailScreenState extends State<ProductsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Geri"),
        backgroundColor: Colors.white,
        leadingWidth: 20,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.product.id ?? 0,
                child: Image.network(
                  widget.product.image ?? "",
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name ?? "",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      widget.product.tagline ?? "",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    SizedBox(height: 16),

                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(widget.product.description ?? ""),

                    SizedBox(height: 10),

                    Text(
                      widget.product.price ?? "N/A",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.cartIds.add(widget.product.id ?? 0);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Ürün sepete eklendi."),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.blue,
                            margin: EdgeInsets.only(
                              bottom: 80,
                              left: 20,
                              right: 20,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size.fromHeight(50),
                      ),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
