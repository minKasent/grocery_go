import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:grocery_go/presentation/bloc/favorite/favorite_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';
import 'package:grocery_go/presentation/shared/app_button.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(FailureMapper(context)),
      child: _FavoriteView(),
    );
  }
}

class _FavoriteView extends StatelessWidget {
  const _FavoriteView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.center,
                  child: AppText(
                    content: "Favorite",
                    style: AppTypography.text20w800,
                  ),
                ),
                SizedBox(height: 20.h),
                Divider(
                  color: AppColorSchemes.lightGrey,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                Expanded(child: BlocBuilder<FavoriteBloc,FavoriteState>(builder: (context,state){
                  if(state.isLoading){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(state.apiErrorMessage.isNotEmpty){
                    return Center(child: AppText(content: "Fail to fetch api"),);
                  }
                  if(state.listOfFavoriteProductsEntity != null){
                    return ListView.builder(
                      itemCount: state.listOfFavoriteProductsEntity!.listOfFavoriteProducts.length,
                      itemBuilder: (context, index) {
                        final item =state.listOfFavoriteProductsEntity!.listOfFavoriteProducts[index];
                        return Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CachedNetworkImage(imageUrl: item.thumbnail),
                              const SizedBox(width: 40),
                              Column(
                                children: [
                                  AppText(
                                    content: item.title,
                                    style: AppTypography.text16w400,
                                  ),
                                  AppText(
                                    content: "${item.price}",
                                    style: AppTypography.text14w600,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              AppText(
                                content: "\$${item.price}",
                                style: AppTypography.text16w400,
                              ),
                              const SizedBox(width: 20),
                              Icon(Icons.navigate_next),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: Text("No data"),);

                })),
              ],
            ),
            Positioned(
              bottom: 50,
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: AppButton(
                  title: "Add All To Cart",
                  backgroundColor: AppColorSchemes.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
