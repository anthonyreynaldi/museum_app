import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:museum_app/models/museum.dart';
// import 'package:project_ambw/models/cart.dart';
// import 'package:project_ambw/models/favorit.dart';
// import 'package:project_ambw/models/product.dart';
// import 'package:project_ambw/models/category.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  Future<List<Museum>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/api/museums'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Museum.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load museums');
    }
  }

  // Future<Product> fetchProductDetails(int productId) async {
  //   final url = Uri.parse('$baseUrl/products/$productId');

  //   try {
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       final responseBody = response.body;
  //       final productData = json.decode(responseBody);

  //       final product = Product.fromJson(productData);
  //       return product;
  //     } else {
  //       throw Exception('Failed to fetch product details');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  // Future<List<Product>> getProductsElektronik() async {
  //   final response = await http.get(Uri.parse('$baseUrl/products/elektronik'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     return jsonData.map((item) => Product.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load elektronik products');
  //   }
  // }

  // Future<List<Product>> getProductsPakaian() async {
  //   final response = await http.get(Uri.parse('$baseUrl/products/pakaian'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     print(jsonData);
  //     return jsonData.map((item) => Product.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load pakaian products');
  //   }
  // }

  // Future<List<Product>> getProductsPrimer() async {
  //   final response = await http.get(Uri.parse('$baseUrl/products/primer'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     print(jsonData);
  //     return jsonData.map((item) => Product.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load pakaian products');
  //   }
  // }

  // Future<List<Product>> getProductsAksesoris() async {
  //   final response = await http.get(Uri.parse('$baseUrl/products/aksesoris'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     print(jsonData);
  //     return jsonData.map((item) => Product.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load pakaian products');
  //   }
  // }

  // Future<List<Product>> getProductsSepatu() async {
  //   final response = await http.get(Uri.parse('$baseUrl/products/sepatu'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     print(jsonData);
  //     return jsonData.map((item) => Product.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load pakaian products');
  //   }
  // }

  // Future<List<Category>> getCategory() async {
  //   final response = await http.get(Uri.parse('$baseUrl/category'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     print(jsonData);
  //     return jsonData.map((item) => Category.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }

  // Future<List<Product>> getRecentProducts() async {
  //   final response = await http.get(Uri.parse('$baseUrl/products'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     final List<dynamic> recentData = jsonData.reversed.take(5).toList();
  //     return recentData.map((item) => Product.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load recent products');
  //   }
  // }

  // Future<List<Product>> getRecomendationProduct() async {
  //   final response = await http.get(Uri.parse('$baseUrl/products'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     final List<dynamic> randomData = jsonData.toList()..shuffle(Random());
  //     final List<dynamic> recomendationData = randomData.take(5).toList();
  //     return recomendationData.map((item) => Product.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load recommendation products');
  //   }
  // }

  // Future<List<Favorite>> getFavorit() async {
  //   final response = await http.get(Uri.parse('$baseUrl/favorit/1'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     print(jsonData);
  //     return jsonData.map((item) => Favorite.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load pakaian products');
  //   }
  // }

  // Future<List<Product>> getFavoriteProducts() async {
  //   final favorites = await getFavorit();
  //   final productIds = favorites.map((favorite) => favorite.productId).toList();
  //   final response = await http.get(Uri.parse('$baseUrl/products'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     final List<Product> products =
  //         jsonData.map((item) => Product.fromJson(item)).toList();
  //     final favoriteProducts =
  //         products.where((product) => productIds.contains(product.id)).toList();
  //     return favoriteProducts;
  //   } else {
  //     throw Exception('Failed to load favorite products');
  //   }
  // }

  // Future<void> addFavoriteProduct(Favorite favoriteProduct) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/favorit'), // Ganti dengan URL endpoint API Anda
  //       body: jsonEncode(favoriteProduct.toJson()),
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     if (response.statusCode == 200) {
  //       // Berhasil menyimpan produk favorit
  //       print('Product favorited successfully');
  //     } else {
  //       // Gagal menyimpan produk favorit
  //       print('Failed to favorite product');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Tangani kesalahan
  //   }
  // }

  // Future<void> deleteFavoriteProduct(int favoriteId, int userId) async {
  //   try {
  //     final response = await http.delete(
  //       Uri.parse(
  //           '$baseUrl/favorit/$favoriteId/$userId'), // Replace with your API endpoint URL
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     if (response.statusCode == 200) {
  //       // Successfully deleted favorite product
  //       print('Favorite product deleted successfully');
  //     } else {
  //       // Failed to delete favorite product
  //       print('Failed to delete favorite product');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle the error
  //   }
  // }

  // Future<List<Favorite>> getFavoritAll() async {
  //   final response = await http.get(Uri.parse('$baseUrl/favorit'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     return jsonData.map((item) => Favorite.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }

  // Future<bool> isFavoriteProduct(int productId, int userId) async {
  //   final url = Uri.parse('$baseUrl/favorit/$productId/$userId');

  //   try {
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       final responseBody = response.body;

  //       final favoriteList = json.decode(responseBody) as List<dynamic>?;

  //       if (favoriteList != null) {
  //         final isFavorite = favoriteList.any((favorite) =>
  //             favorite['product_id'] == productId &&
  //             favorite['user_id'] == userId);

  //         return isFavorite;
  //       }

  //       throw Exception('Failed to fetch favorite status');
  //     } else {
  //       throw Exception('Failed to fetch favorite status');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  // Future<List<Cart>> getCart() async {
  //   final response = await http.get(Uri.parse('$baseUrl/cart/1'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     return jsonData.map((item) => Cart.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load pakaian products');
  //   }
  // }

  // Future<List<Product>> getCartProducts() async {
  //   final cart = await getCart();
  //   final productIds = cart.map((cart) => cart.productId).toList();
  //   final response = await http.get(Uri.parse('$baseUrl/products'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     final List<Product> products =
  //         jsonData.map((item) => Product.fromJson(item)).toList();
  //     final cartProducts =
  //         products.where((product) => productIds.contains(product.id)).toList();
  //     return cartProducts;
  //   } else {
  //     throw Exception('Failed to load favorite products');
  //   }
  // }

  // Future<void> addCartProduct(Cart cart) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/cart'), // Ganti dengan URL endpoint API Anda
  //       body: jsonEncode(cart.toJson()),
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     if (response.statusCode == 200) {
  //       // Berhasil menyimpan produk favorit
  //       print('Product Cart successfully');
  //     } else {
  //       // Gagal menyimpan produk favorit
  //       print('Failed to Cart product');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Tangani kesalahan
  //   }
  // }

  // Future<void> deleteCartProduct(int userId, int productId) async {
  //   try {
  //     final response = await http.delete(
  //       Uri.parse(
  //           '$baseUrl/cart/$userId/$productId'), // Replace with your API endpoint URL
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     if (response.statusCode == 200) {
  //       // Successfully deleted favorite product
  //       print('Favorite product deleted successfully');
  //     } else {
  //       // Failed to delete favorite product
  //       print('Failed to delete favorite product');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle the error
  //   }
  // }

  // Future<void> updateCartProduct(
  //     int userId, int productId, int quantity) async {
  //   try {
  //     final response = await http.put(
  //       Uri.parse(
  //           '$baseUrl/cart/$userId/$productId'), // Replace with your API endpoint URL
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'quantity': quantity}),
  //     );

  //     if (response.statusCode == 200) {
  //       // Successfully updated cart product
  //       print('Cart product updated successfully');
  //     } else {
  //       // Failed to update cart product
  //       print('Failed to update cart product');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle the error
  //   }
  // }
}
