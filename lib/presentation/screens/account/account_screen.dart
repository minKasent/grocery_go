import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/presentation/bloc/account/account_bloc.dart';
import 'package:grocery_go/presentation/bloc/account/account_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';
import 'package:grocery_go/presentation/shared/app_button.dart';
import 'package:grocery_go/presentation/shared/app_text.dart';
import 'package:grocery_go/presentation/theme/app_color_schemes.dart';
import 'package:grocery_go/presentation/theme/app_typography.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(FailureMapper(context)),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.userInfoEntity == null) {
            return Center(child: Text("Can't get user info"));
          }
          return Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  SizedBox(height: kToolbarHeight),
                  Row(
                    children: [
                      CircleAvatar(
                        child: CachedNetworkImage(
                          imageUrl: state.userInfoEntity!.image,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AppText(
                                content: state.userInfoEntity!.fullName,
                                style: AppTypography.text16w600.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Icon(
                                Icons.edit_outlined,
                                color: AppColorSchemes.green,
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          AppText(
                            content: state.userInfoEntity!.email,
                            style: AppTypography.text16w400.copyWith(
                              color: AppColorSchemes.grey,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  ..._buildListItems(),
                  SizedBox(height: 20.h),
                  AppButton(title: 'Log out',),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Column _buildItemWidget({required String title, required String iconPath}) {
    return Column(
      children: [
        Divider(
          color: AppColorSchemes.lightGrey,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageIcon(AssetImage(iconPath)),
            SizedBox(width: 15.w),
            AppText(
              content: title,
              style: AppTypography.text18w600.copyWith(
                color: AppColorSchemes.black,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_outlined,size: 20,),
          ],
        ),
        SizedBox(height: 10.h),
        // Divider(
        //   color: AppColorSchemes.lightGrey,
        //   thickness: 1,
        //   indent: 0,
        //   endIndent: 0,
        // ),
      ],
    );
  }
  List<Widget> _buildListItems() {
    return [
      _buildItemWidget(
        title: "Orders",
        iconPath: Assets.icons.orderIc.path,
      ),
      _buildItemWidget(
        title: "My Details",
        iconPath: Assets.icons.myDetailIc.path,
      ),
      _buildItemWidget(
        title: "Delivery Address",
        iconPath: Assets.icons.deliveryIc.path,
      ),
      _buildItemWidget(
        title: "Payment Methods",
        iconPath: Assets.icons.paymentIc.path,
      ),
      _buildItemWidget(
        title: "Promo Code",
        iconPath: Assets.icons.promoCordIc.path,
      ),
      _buildItemWidget(
        title: "Notifications",
        iconPath: Assets.icons.bellIc.path,
      ),
      _buildItemWidget(
        title: "Help",
        iconPath: Assets.icons.helpIcon.path,
      ),
      _buildItemWidget(
        title: "About",
        iconPath: Assets.icons.aboutIcon.path,
      ),
      Divider(
        color: AppColorSchemes.lightGrey,
        thickness: 1,
        indent: 0,
        endIndent: 0,
      ),
    ];
  }
}
