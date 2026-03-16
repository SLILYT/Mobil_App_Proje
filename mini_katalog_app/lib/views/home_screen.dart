import 'package:flutter/material.dart';
import 'package:mini_katalog_app/components/product_card.dart';
import 'package:mini_katalog_app/model/products_model.dart';
import 'package:mini_katalog_app/services/api_sercive.dart';
import 'package:mini_katalog_app/views/cart_screen.dart';
import 'package:mini_katalog_app/views/products_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  String errorMessage = "";
  List<Data> allProducts = [];
  ApiSercive apiService = ApiSercive();
  final Set<int> cartIds = {};
  String searchQuery = "";

  @override
  void initState() {
    loadProducts();

    super.initState();
  }

  Future<void> loadProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      ProductsModel resData = await apiService.fetchProducts();

      setState(() {
        allProducts = resData.data ?? [];
      });
    } catch (e) {
      setState(() {
        errorMessage = "Ürünleri yüklerken hata oluştu.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = allProducts.where((product) {
      final name = product.name ?? "";
      return name.toUpperCase().contains(searchQuery.toUpperCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mini Katalog",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(
                            products: allProducts,
                            cartIds: cartIds,
                          ),
                        ),
                      );
                    },
                    iconSize: 32,
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),

              SizedBox(height: 8),

              Text(
                "Find your perfect device.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 14),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller:
                      searchController, //kullanıcının girdiği değere erişeceğimiz controller
                  decoration: InputDecoration(
                    hintText: "Ürün ara...",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsetsDirectional.symmetric(
                      vertical: 14,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),

              SizedBox(height: 16),

              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://wantapi.com/assets/banner.png",
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

              SizedBox(height: 16),

              if (isLoading)
                Center(child: CircularProgressIndicator())
              else if (errorMessage != "")
                Center(child: Text(errorMessage))
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),

                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsDetailScreen(
                                product: product,
                                cartIds: cartIds,
                              ),
                            ),
                          );
                        },
                        child: ProductCard(product: product),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
