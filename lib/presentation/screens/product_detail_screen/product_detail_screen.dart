import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';
import 'package:grocery_go/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:grocery_go/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:grocery_go/presentation/bloc/product_detail/product_detail_state.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc(),
      child: ProductDetailView(productEntity: productEntity),
    );
  }
}

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSlider(),
            _buildTitleRow(),
            _buildWeightText(),
            _buildQuantityPriceRow(),
            _buildExpansionSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      buildWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 220,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.productEntity.images.length,
                onPageChanged: (index) {
                  context.read<ProductDetailBloc>().add(
                    OnChangeImageIndexEvent(index),
                  );
                },
                itemBuilder: (context, index) {
                  final images = widget.productEntity.images;
                  return CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.productEntity.images.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: state.currentIndex == index ? 10 : 6,
                  height: state.currentIndex == index ? 10 : 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state.currentIndex == index
                        ? Colors.green
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTitleRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.productEntity.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          BlocBuilder<ProductDetailBloc, ProductDetailState>(
            buildWhen: (previous, current) =>
                previous.isFavorite != current.isFavorite,
            builder: (context, state) {
              final isFavorite = state.isFavorite;
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  context.read<ProductDetailBloc>().add(
                    OnToggleFavoriteEvent(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeightText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text("1kg, Price", style: TextStyle(color: Colors.grey)),
    );
  }

  Widget _buildQuantityPriceRow() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<ProductDetailBloc, ProductDetailState>(
            buildWhen: (previous, current) =>
                previous.quantity != current.quantity,
            builder: (context, state) {
              return Row(
                children: [
                  _buildQuantityButton(Icons.remove, () {
                    if (state.quantity > 1) {
                      context.read<ProductDetailBloc>().add(
                        OnChangeQuantityEvent((state.quantity - 1)),
                      );
                    }
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      state.quantity.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  _buildQuantityButton(Icons.add, () {
                    context.read<ProductDetailBloc>().add(
                      OnChangeQuantityEvent((state.quantity + 1)),
                    );
                  }),
                ],
              );
            },
          ),
          Text(
            "\$${widget.productEntity.price}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 20),
      ),
    );
  }

  Widget _buildExpansionSection() {
    return Column(
      children: [
        _buildExpansionTile(
          title: "Product Detail",
          content: widget.productEntity.description,
        ),
        _buildExpansionTile(
          title: "Nutritions",
          content: "100gr contains vitamins, minerals and fiber.",
        ),
        _buildExpansionTile(title: "Review", content: "⭐️⭐️⭐️⭐️⭐️"),
      ],
    );
  }

  Widget _buildExpansionTile({required String title, required String content}) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(content, style: const TextStyle(color: Colors.black87)),
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: const Text(
          "Add To Basket",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
