import 'package:flutter/material.dart';
import 'package:mini_katalog_app/model/products_model.dart';

class ProductCard extends StatelessWidget {
  final Data product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: product.id ?? 0,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(product.image ?? ""),
              ),
            ),
          ),

          Text(
            product.name ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          SizedBox(height: 1),

          Text(
            product.tagline ?? "",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),

          SizedBox(height: 1),

          Text(
            product.price ?? "N/A",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.red.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
