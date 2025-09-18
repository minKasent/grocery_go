import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/core/extensions/context_extention.dart';
import 'package:grocery_go/presentation/bloc/shop/shop_bloc.dart';
import 'package:grocery_go/presentation/bloc/shop/shop_event.dart';
import 'package:grocery_go/presentation/bloc/shop/shop_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/shared/app_text_field.dart';
import 'package:grocery_go/presentation/shared/common_dialogs.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopBloc(FailureMapper(context)),
      child: _ShopView(),
    );
  }
}

class _ShopView extends StatelessWidget {
  const _ShopView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopBloc, ShopState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 58.h),
              Image.asset(
                Assets.icons.googleIc.path,
                color: AppColorSchemes.green,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.icons.googleIc.path,
                    color: AppColorSchemes.green,
                  ),
                  SizedBox(width: 7.w),
                  AppText(content: 'Dhaka, Banassre'),
                ],
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: SearchTextField(title: 'Search Store',),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 115.h,
                width: context.screenWidth - 46.w,
                child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl:
                          'https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/1.webp',
                      width: context.screenWidth - 46.w,
                      height: 115.h,
                    );
                  },
                ),
              ),
              if (state.listOfCategoryProductsEntity != null)
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24.w),
                  itemBuilder: (context, index) {
                    final item = state
                        .listOfCategoryProductsEntity!
                        .listOfCategoryProductsEntity[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(content: item.category),
                            AppText(content: 'See All'),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          height: 250.h,
                          width: context.screenWidth - 24.w,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final product = item.products[index];
                              return Container(
                                width: (context.screenWidth - 40.w) / 2,
                                height: 250.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: Colors.grey),
                                ),
                                padding: EdgeInsets.all(15.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                      child: CachedNetworkImage(
                                        imageUrl: product.thumbnail,
                                        width: 90.w,
                                        height: 80.h,
                                      ),
                                    ),
                                    // SizedBox(height: 25.h),
                                    AppText(content: product.title),
                                    AppText(content: product.weight.toString()),
                                    // SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(content: '\$${product.price}'),
                                        Container(
                                          height: 45.w,
                                          width: 45.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              100.r,
                                            ),
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 15.w);
                            },
                            itemCount: item.products.length,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, state) {
                    return SizedBox(height: 30.h);
                  },
                  itemCount: state
                      .listOfCategoryProductsEntity!
                      .listOfCategoryProductsEntity
                      .length,
                ),
              SizedBox(height: 100.h),
            ],
          ),
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
              onTap: () =>
                  context.read<ShopBloc>().add(OnClearShopErrorMessageEvent()),
            );
          }
        }
      },
    );
  }
}
