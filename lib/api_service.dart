import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:museum_app/models/museum.dart';

import 'models/comment.dart';
import 'package:museum_app/models/user.dart';
// import 'package:project_ambw/models/cart.dart';
// import 'package:project_ambw/models/favorit.dart';
// import 'package:project_ambw/models/product.dart';
// import 'package:project_ambw/models/category.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  Future<List<Museum>> getMuseum() async {
    final response = await http.get(Uri.parse('$baseUrl/api/museums'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData.map((item) => Museum.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load museums');
    }
  }

  static getToken() async {
    final storage = new FlutterSecureStorage();
    var jwt = await storage.read(key: 'jwt');

    jwt =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODc0NDY0NzIsImV4cCI6MTY4NzUzMjg3MiwibmJmIjoxNjg3NDQ2NDcyLCJqdGkiOiI5YnloZVFHb0hkOE9HcDhVIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.J7206DHXLBOS-zLJZXdCbj3xIZV7kLMlnMiMP6ahLHE";

    return jwt;
  }

  static Future<List<Comment>> getComments(museumId) async {
    var token = await getToken() as String;

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    print("send request");

    final response = await http
        .get(Uri.parse('$baseUrl/api/comments/$museumId'), headers: header);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData.map((item) => Comment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load comment');
    }
  }

  static postComments(museumId, komentar) async {
    var token = await getToken() as String;

    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token
    };

    Map paramData = {
      'komentar': komentar,
      'museumId': museumId,
    };

    var body = json.encode(paramData);

    print("send request post comment");

    final response = await http.post(Uri.parse('$baseUrl/api/comment'),
        headers: header, body: body);
    if (response.statusCode == 201) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post comment');
    }
  }

  Future<List<Museum>> getMuseumById(int id) async {
    print('id: $id');
    final response = await http.get(Uri.parse('$baseUrl/api/museum/$id'));
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Museum.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load museums');
    }
  }

  Future<List<Museum>> getFavoriteMuseums() async {
    //use bearer token
    final response = await http.get(
      Uri.parse('$baseUrl/api/favorites'),
      headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODc0NDQ3NzksImV4cCI6MTY4NzUzMTE3OSwibmJmIjoxNjg3NDQ0Nzc5LCJqdGkiOiI4eGw4NXdSb0FyWnZhSEFNIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.2TnAtYPmR9xih-nonxJXN05fbq94dYoj3JVr0xO_tEk', // Include bearer token in the headers
      },
    );

    print("lola");
    print(response.statusCode);
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Museum.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load museums');
    }
  }

  Future<User> getProfile() async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/auth/profile'), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODc0NDQ3NzksImV4cCI6MTY4NzUzMTE3OSwibmJmIjoxNjg3NDQ0Nzc5LCJqdGkiOiI4eGw4NXdSb0FyWnZhSEFNIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.2TnAtYPmR9xih-nonxJXN05fbq94dYoj3JVr0xO_tEk'
    });
    print("lol");
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  //return json response function

  Future<Map<String, dynamic>> deleteFavorite(int museumId) async {
    print("museumId: $museumId");
    final response = await http.post(
      Uri.parse('$baseUrl/api/delete-favorite'),
      headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODc0NDQ3NzksImV4cCI6MTY4NzUzMTE3OSwibmJmIjoxNjg3NDQ0Nzc5LCJqdGkiOiI4eGw4NXdSb0FyWnZhSEFNIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.2TnAtYPmR9xih-nonxJXN05fbq94dYoj3JVr0xO_tEk',
      },
      body: {
        'museumId': museumId.toString()
      }, // Pass museumId in the request body
    );

    // Process the response and return the result
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to delete favorite');
    }
  }

  Future<Map<String, dynamic>> storeFavorite(int museumId) async {
    print("museumId: $museumId");
    final response = await http.post(
      Uri.parse('$baseUrl/api/favorite'),
      headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODc0NDQ3NzksImV4cCI6MTY4NzUzMTE3OSwibmJmIjoxNjg3NDQ0Nzc5LCJqdGkiOiI4eGw4NXdSb0FyWnZhSEFNIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.2TnAtYPmR9xih-nonxJXN05fbq94dYoj3JVr0xO_tEk',
      },
      body: {
        'museumId': museumId.toString()
      }, // Pass museumId in the request body
    );

    // Process the response and return the result
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to store favorite');
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
