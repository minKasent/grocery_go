import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_go/presentation/bloc/explore/explore_bloc.dart';
import 'package:grocery_go/presentation/bloc/explore/explore_event.dart';
import 'package:grocery_go/presentation/bloc/explore/explore_state.dart';
import 'package:grocery_go/presentation/bloc/shop/shop_bloc.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/shared/common_dialogs.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreBloc(FailureMapper(context)),
      child: _ExploreView(),
    );
  }
}

class _ExploreView extends StatelessWidget {
  const _ExploreView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExploreBloc, ExploreState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(height: 58.h),
            AppText(content: 'Dhaka, Banassre'),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: TextField(
                onChanged: (value) {
                  context.read<ExploreBloc>().add(OnSearchCategoryEvent(value));
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: state.categoryEntity.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  final item = state.categoryEntity[index];
                  final random = Random();

                  // random màu nền & border
                  final bgColor = Colors
                      .primaries[random.nextInt(Colors.primaries.length)]
                      .shade50;

                  final borderColor =
                      Colors.primaries[random.nextInt(Colors.primaries.length)];

                  return Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      border: Border.all(color: borderColor, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: item.thumbnail,
                            fit: BoxFit.contain,
                            height: 75.h,
                            width: 112.w,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            item.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
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
              onTap: () => context.read<ExploreBloc>().add(
                OnClearExploreErrorMessageEvent(),
              ),
            );
          }
        }
      },
    );
  }
}
