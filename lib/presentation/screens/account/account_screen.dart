import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_go/core/assets_gen/assets.gen.dart';
import 'package:grocery_go/core/enum/enum_button.dart';
import 'package:grocery_go/l10n/app_localizations.dart';
import 'package:grocery_go/presentation/bloc/account/account_bloc.dart';
import 'package:grocery_go/presentation/bloc/account/account_state.dart';
import 'package:grocery_go/presentation/bloc/locale/locale_bloc.dart';
import 'package:grocery_go/presentation/bloc/locale/locale_event.dart';
import 'package:grocery_go/presentation/bloc/locale/locale_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';
import 'package:grocery_go/presentation/routes/route_name.dart';
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
                  ..._buildListItems(context),
                  SizedBox(height: 30.h),
                  AppButton(
                    onTap: () {
                      /// log out
                      // context.read<AccountBloc>().add(LogoutEvent());
                      context.go(RouteName.login);
                    },
                    leftIconPath: true,
                    buttonState: ButtonState.second,
                    title: 'Log out',
                    backgroundColor: AppColorSchemes.green,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column _buildItemWidget({
    required String title,
    required String iconPath,
    bool hasSwitch = false,
  }) {
    return Column(
      children: [
        _buildDividerWidget(),
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
            if (!hasSwitch) Icon(Icons.arrow_forward_ios_outlined, size: 20),
            if (hasSwitch)
              BlocBuilder<LocaleBloc, LocaleState>(
                builder: (context, state) {
                  return Switch(
                    value: state.locale == 'en',
                    onChanged: (value) {
                      final locale = value ? 'en' : 'vi';
                      context.read<LocaleBloc>().add(
                        OnChangeLocaleEvent(locale),
                      );
                    },
                  );
                },
              ),
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

  List<Widget> _buildListItems(BuildContext context) {
    return [
      _buildItemWidget(
        title: AppLocalizations.of(context).orders,
        iconPath: Assets.icons.orderIc.path,
      ),
      _buildItemWidget(
        title: AppLocalizations.of(context).myDetails,
        iconPath: Assets.icons.myDetailIc.path,
      ),
      _buildItemWidget(
        title: AppLocalizations.of(context).deliveryAddress,
        iconPath: Assets.icons.deliveryIc.path,
      ),
      _buildItemWidget(
        title: AppLocalizations.of(context).paymentMethods,
        iconPath: Assets.icons.paymentIc.path,
      ),
      _buildItemWidget(
        title: AppLocalizations.of(context).promoCode,
        iconPath: Assets.icons.promoCordIc.path,
      ),
      _buildItemWidget(
        title: AppLocalizations.of(context).notifications,
        iconPath: Assets.icons.bellIc.path,
      ),
      _buildItemWidget(
        title: AppLocalizations.of(context).help,
        iconPath: Assets.icons.helpIcon.path,
      ),
      _buildItemWidget(
        title: AppLocalizations.of(context).about,
        iconPath: Assets.icons.aboutIcon.path,
      ),
      _buildItemWidget(
        title: AppLocalizations.of(context).language,
        iconPath: Assets.icons.aboutIcon.path,
        hasSwitch: true,
      ),
      _buildDividerWidget(),
    ];
  }

  /// DRY : Don't repeat your code
  Divider _buildDividerWidget() {
    return Divider(
      color: AppColorSchemes.lightGrey,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }
}
