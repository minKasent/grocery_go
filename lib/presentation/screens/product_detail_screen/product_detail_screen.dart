import 'package:chottu_link/chottu_link.dart';
import 'package:chottu_link/dynamic_link/cl_dynamic_link_behaviour.dart';
import 'package:chottu_link/dynamic_link/cl_dynamic_link_parameters.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_go/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:grocery_go/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:grocery_go/presentation/bloc/product_detail/product_detail_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';
import 'package:grocery_go/presentation/routes/route_name.dart';
import 'package:grocery_go/presentation/shared/common_dialogs.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.productId,
    this.isFromDeepLink = false,
  });
  final int productId;
  final bool isFromDeepLink;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailBloc(FailureMapper(context))
            ..add(OnGetSingleProductEvent(productId)),
      child: ProductDetailView(
        productId: productId,
        isFromDeepLink: isFromDeepLink,
      ),
    );
  }
}

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    super.key,
    required this.productId,
    this.isFromDeepLink = false,
  });
  final int productId;
  final bool isFromDeepLink;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state.product == null) {
          return const SizedBox.shrink();
        }
        return Scaffold(
          appBar: _buildAppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageSlider(),
                _buildTitleRow(state),
                _buildWeightText(),
                _buildQuantityPriceRow(state),
                _buildExpansionSection(state),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomButton(),
        );
      },
      listener: (context, state) {
        if (state.isLoading) {
          CommonDialogs.showLoadingDialog(context);
        } else {
          CommonDialogs.hideLoadingDialog(context);
          if (state.errorMessage.isNotEmpty) {
            CommonDialogs.showErrorDialog(
              context: context,
              title: 'Error',
              message: state.errorMessage,
              onTap: () => context.read<ProductDetailBloc>().add(
                OnClearProductDetailErrorMessageEvent(),
              ),
            );
          }
        }
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          if (widget.isFromDeepLink) {
            context.go(RouteName.dashboard);
          } else {
            context.pop();
          }
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share, color: Colors.black),
          onPressed: () async {
            await _onShareFunction();
          },
        ),
      ],
    );
  }

  Future<void> _onShareFunction() async {
    /// Create dynamic link parameters
    final parameters = CLDynamicLinkParameters(
      link: Uri.parse(
        "https://onlinegroceries.chottu.link/product/${widget.productId}",
      ), // Target deep link
      domain: "onlinegroceries.chottu.link", // Your ChottuLink domain
      // Set behavior for Android & iOS
      androidBehaviour: CLDynamicLinkBehaviour.app,
      iosBehaviour: CLDynamicLinkBehaviour.app,

      // // UTM Tracking (for analytics)
      // utmCampaign: "exampleCampaign",
      // utmMedium: "exampleMedium",
      // utmSource: "exampleSource",
      // utmContent: "exampleContent",
      // utmTerm: "exampleTerm",

      // // Optional metadata
      // linkName: "linkname",
      // selectedPath: "customPath",
      // socialTitle: "Social Title",
      // socialDescription: "Description to show when shared",
      // socialImageUrl:
      //     "https://yourdomain.com/image.png", // Must be a valid image URL
    );

    await Future.delayed(
      const Duration(milliseconds: 100),
    ); // Small delay to ensure UI is ready

    ChottuLink.createDynamicLink(
      parameters: parameters,
      onSuccess: (link) {
        debugPrint("✅ Shared Link: $link"); // 🔗 Successfully created link
        SharePlus.instance.share(
          ShareParams(title: "Check out this product", uri: Uri.parse(link)),
        );
      },
      onError: (error) {
        debugPrint("❌ Error creating link: ${error.description}");
        SharePlus.instance.share(
          ShareParams(
            title: "Check out this product",
            uri: Uri.parse(
              "https://onlinegroceries.chottu.link/product/${widget.productId}",
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSlider() {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      buildWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        final product = state.product;
        return Column(
          children: [
            SizedBox(
              height: 220,
              child: PageView.builder(
                controller: _pageController,
                itemCount: product?.images.length ?? 0,
                onPageChanged: (index) {
                  context.read<ProductDetailBloc>().add(
                    OnChangeImageIndexEvent(index),
                  );
                },
                itemBuilder: (context, index) {
                  final images = product?.images ?? [];
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
                product?.images.length ?? 0,
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

  Widget _buildTitleRow(ProductDetailState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            state.product?.title ?? '',
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

  Widget _buildQuantityPriceRow(ProductDetailState state) {
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
            "\$${state.product?.price ?? 0}",
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

  Widget _buildExpansionSection(ProductDetailState state) {
    return Column(
      children: [
        _buildExpansionTile(
          title: "Product Detail",
          content: state.product?.description ?? '',
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
