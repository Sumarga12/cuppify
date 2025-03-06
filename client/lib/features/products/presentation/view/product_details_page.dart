import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/presentation/view_model/cart_cubit.dart';
import '../../domain/entities/product.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final TextEditingController _commentController = TextEditingController();
  final int _selectedRating = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Changed background color to white
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Changed AppBar color to green
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLayout(),
              // _buildCommentsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: CachedNetworkImage(
              imageUrl: widget.product.images ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
              errorWidget: (context, error, stackTrace) {
                return Container(
                  height: 300,
                  color: Colors.grey[800],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 64),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildProductDetails(),
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.product.name,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: "  (${widget.product.category})",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Text(
          "Rs. ${widget.product.price}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        // Rating
        Row(
          children: [
            ...List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: index < ((widget.product.rating?.round() ?? 5))
                    ? Colors.orange
                    : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              // If rating is null, defaults to '5'
              "${widget.product.rating ?? 5} out of 5 Stars",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () =>
                context.read<CartCubit>().addNewCart(widget.product.id),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon:
                const Icon(Icons.shopping_cart, size: 24, color: Colors.white),
            label: const Text(
              "Add to Cart",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Description
        const Text(
          "Description",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Best in the Town",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  // ... (Comments section code remains commented out and unchanged) ...

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
