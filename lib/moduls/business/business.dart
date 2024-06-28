import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/share/componeuts/componut.dart';

import '../../cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppNewsCubit, AppNewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppNewsCubit.get(context);
        var listBusiness = cubit.business;
        return buildArtical(list: listBusiness, context: context);
      },
    );
  }
}
