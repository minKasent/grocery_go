import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';
import 'package:grocery_go/presentation/bloc/category_product/category_product_bloc.dart';
import 'package:grocery_go/presentation/bloc/category_product/category_product_event.dart';
import 'package:grocery_go/presentation/bloc/category_product/category_product_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';
import 'package:grocery_go/presentation/shared/common_dialogs.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({super.key, required this.slug});
  final String slug;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryProductBloc(FailureMapper(context))
            ..add(OnFetchListOfProductsEvent(slug)),
      child: const CategoryProductView(),
    );
  }
}

class CategoryProductView extends StatelessWidget {
  const CategoryProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<CategoryProductBloc, CategoryProductState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: _buildGridView(state),
          );
        },
        listener: (context, state) {
          if (state.isLoading) {
            CommonDialogs.showLoadingDialog(context);
          } else {
            CommonDialogs.hideLoadingDialog(context);
            if (state.apiErrorMessage.isNotEmpty) {
              CommonDialogs.showErrorDialog(
                context: context,
                title: 'Error',
                message: state.apiErrorMessage,
                onTap: () => context.read<CategoryProductBloc>().add(
                  OnClearCategoryProductErrorMessageEvent(),
                ),
              );
            }
          }
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Beverages",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildGridView(CategoryProductState state) {
    if (state.listOfProductsEntity == null ||
        state.listOfProductsEntity!.listOfProductsEntity.isEmpty) {
      return const Center(child: Text("No products available"));
    }
    return GridView.builder(
      itemCount: state.listOfProductsEntity!.listOfProductsEntity.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final product = state.listOfProductsEntity!.listOfProductsEntity[index];
        return _buildProductItem(product);
      },
    );
  }

  Widget _buildProductItem(ProductEntity product) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(product.thumbnail),
          _buildProductInfo(product),
          const Spacer(),
          _buildPriceRow(product),
        ],
      ),
    );
  }

  Widget _buildProductImage(String url) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: CachedNetworkImage(
        imageUrl: url,
        height: 100,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildProductInfo(ProductEntity product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            "${product.weight}, Price",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(ProductEntity product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\$${product.price}",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.white),
              iconSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
