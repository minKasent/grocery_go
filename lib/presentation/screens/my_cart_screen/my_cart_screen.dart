import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_go/data/models/params/update_a_cart_param.dart';
import 'package:grocery_go/data/models/requests/update_a_cart_schema.dart';
import 'package:grocery_go/presentation/bloc/cart/cart_bloc.dart';
import 'package:grocery_go/presentation/bloc/cart/cart_event.dart';
import 'package:grocery_go/presentation/bloc/cart/cart_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';
import 'package:grocery_go/presentation/shared/app_button.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/shared/common_dialogs.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(FailureMapper(context)),
      child: MyCartView(),
    );
  }
}

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(content: "Favorite", style: AppTypography.text20w800),
      ),
      body: BlocListener<CartBloc, CartState>(
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
                onTap: () => context.read<CartBloc>().add(
                  OnClearCartErrorMessageEvent(),
                ),
              );
            }
          }
        },
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20.h),
                Divider(
                  color: AppColorSchemes.lightGrey,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                Expanded(
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state.cartEntity == null) {
                        return Center(child: Text("No card"));
                      }
                      return ListView.builder(
                        itemCount:
                            state.cartEntity!.products.listCartEntity.length,
                        padding: EdgeInsets.only(bottom: 100.h),
                        itemBuilder: (context, index) {
                          final item =
                              state.cartEntity!.products.listCartEntity[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.h,
                              vertical: 20.h,
                            ),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: item.thumbnail,
                                  width: 45.w,
                                  height: 45.w,
                                ),
                                SizedBox(width: 40.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        content: item.title,
                                        style: AppTypography.text16w400,
                                      ),
                                      AppText(
                                        content: "1kg, Price",
                                        style: AppTypography.text14w600,
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          _buildCounterButton(
                                            Icons.remove,
                                            onTap: () {
                                              if (item.quantity < 2) {
                                                /// TODO: show popup noti
                                              } else {
                                                context.read<CartBloc>().add(
                                                  OnUpdateACartEvent(
                                                    UpdateACartParam(
                                                      schema: UpdateACartSchema(
                                                        merge: true,
                                                        products: [
                                                          UpdateAProductSchema(
                                                            id: item.id,
                                                            quantity:
                                                                (item.quantity -
                                                                        1)
                                                                    .toString(),
                                                          ),
                                                        ],
                                                      ),
                                                      id: state.cartEntity!.id,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          SizedBox(width: 15.w),
                                          AppText(
                                            content: item.quantity.toString(),
                                            style: AppTypography.text18w600
                                                .copyWith(
                                                  color: AppColorSchemes.black,
                                                ),
                                          ),
                                          SizedBox(width: 15.w),
                                          _buildCounterButton(
                                            Icons.add,
                                            onTap: () {
                                              context.read<CartBloc>().add(
                                                OnUpdateACartEvent(
                                                  UpdateACartParam(
                                                    schema: UpdateACartSchema(
                                                      merge: true,
                                                      products: [
                                                        UpdateAProductSchema(
                                                          id: item.id,
                                                          quantity:
                                                              (item.quantity +
                                                                      1)
                                                                  .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                    id: state.cartEntity!.id,
                                                  ),
                                                ),
                                              );
                                            },
                                            iconColor: AppColorSchemes.green,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context.read<CartBloc>().add(
                                          OnDeleteAProductEvent(item.id),
                                        );
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 25,
                                        color: AppColorSchemes.grey,
                                      ),
                                    ),
                                    SizedBox(height: 35.h),
                                    AppText(
                                      content: "\$${item.price}",
                                      style: AppTypography.text18w600.copyWith(
                                        color: AppColorSchemes.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return AppButton(
                      title: "Go to Checkout",
                      subText: '\$${state.cartEntity!.total}',
                      backgroundColor: AppColorSchemes.green,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildCounterButton(
    IconData icon, {
    VoidCallback? onTap,
    Color iconColor = Colors.black,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: AppColorSchemes.lightGrey),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Icon(icon, size: 25, color: iconColor),
      ),
    );
  }
}
