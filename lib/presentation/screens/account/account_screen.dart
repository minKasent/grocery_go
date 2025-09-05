import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_go/presentation/bloc/account/account_bloc.dart';
import 'package:grocery_go/presentation/bloc/account/account_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';

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
                              Text(state.userInfoEntity!.fullName),
                              SizedBox(width: 10.w),
                              Icon(Icons.edit),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Text(state.userInfoEntity!.email),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
