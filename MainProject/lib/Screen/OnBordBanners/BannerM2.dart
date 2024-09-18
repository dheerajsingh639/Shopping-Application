import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:googlelogin/Screen/OnBordBanners/BannerM1.dart';

class BannerM2 extends StatefulWidget {
  const BannerM2({super.key});

  @override
  State<BannerM2> createState() => _BannerM2State();
}

class _BannerM2State extends State<BannerM2> {

  final Map<int, bool> _favoriteStates = {};
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(padding),
        child: GridView.builder(
          itemCount: demoProducts.length, // Number of items in the grid
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0, // Maximum width for each grid item
            mainAxisSpacing: padding,
            crossAxisSpacing: padding,
            childAspectRatio: 0.66, // Aspect ratio of each grid item
          ),
          itemBuilder: (context, index) {
            return ProductCard(
              product: demoProducts[index], // Pass product data to the card
              isFavorite: _favoriteStates[index] ?? false,
              onFavoriteToggle: () {
                setState(() {
                  _favoriteStates[index] = !(_favoriteStates[index] ?? false);
                });
              },
              onPress: () {
                // Handle product card press here
              },
            );
          },
        ),
      ),
    );
  }
}

// Widget for displaying each product card
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onPress,
  });

  final Product product;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 2), // Border around the card
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Favorite Button
            Stack(
              children: [
                ProductImage(imageUrl: product.image), // Display the product image
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    onPressed: onFavoriteToggle, // Handle favorite toggle
                    color: isFavorite ? Colors.red : Colors.white,
                  ),
                ),
                if (product.discount != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: DiscountBadge(discount: product.discount!), // Show discount badge if available
                  ),
              ],
            ),
            const SizedBox(height: padding / 2),
            Text(
              product.brandName.toUpperCase(), // Display brand name
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: padding / 2),
            Text(
              product.title, // Display product title
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
            const Spacer(),
            PriceTag(
              price: product.price,
              discountPrice: product.discountPrice,
            ), // Display price
          ],
        ),
      ),
    );
  }
}

// Widget for displaying the product image
class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.15,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => Container(
          color: Colors.grey[300], // Placeholder while loading
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

// Widget for displaying the discount badge
class DiscountBadge extends StatelessWidget {
  const DiscountBadge({super.key, required this.discount});

  final int discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: padding / 2),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "$discount% OFF",
        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Widget for displaying the price
class PriceTag extends StatelessWidget {
  const PriceTag({super.key, required this.price, this.discountPrice});

  final double price;
  final double? discountPrice;

  @override
  Widget build(BuildContext context) {
    return discountPrice != null
        ? Row(
            children: [
              Text(
                "\$$discountPrice",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "\$$price",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          )
        : Text(
            "\$$price",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          );
  }
}

// Data model for Product
class Product {
  final String image, brandName, title;
  final double price;
  final double? discountPrice;
  final int? discount;

  Product({
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.discountPrice,
    this.discount,
  });
}

// Sample data for the products
List<Product> demoProducts = [
  Product(
    image: "https://i.imgur.com/AkzWQuJ.png",
    title: "Mountain Warehouse for Women",
    brandName: "Lipsy London",
    price: 540,
    discountPrice: 420,
    discount: 20,
  ),
  Product(
    image: "https://i.imgur.com/q9oF9Yq.png",
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy London",
    price: 800,
  ),
  Product(
    image: "https://i.imgur.com/MsppAcx.png",
    title: "FS - Nike Air Max 270 React",
    brandName: "Lipsy London",
    price: 650.62,
    discountPrice: 390.36,
    discount: 40,
  ),
  Product(
    image: "https://i.imgur.com/JfyZlnO.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy London",
    price: 1264,
    discountPrice: 1200.8,
    discount: 5,
  ),
  Product(
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy London",
    price: 650.62,
    discountPrice: 390.36,
    discount: 40,
  ),
  Product(
    image: "https://i.imgur.com/h2LqppX.png",
    title: "White Satin Corset Top",
    brandName: "Lipsy London",
    price: 1264,
    discountPrice: 1200.8,
    discount: 5,
  ),
];
