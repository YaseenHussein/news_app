import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';

import '../../cubit/cubit2.dart';
import '../../cubit/states.dart';
import '../../share/componeuts/componut.dart';

class SearchScreen extends StatelessWidget {
  var searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppNewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultTextInput(
                typeKeybord: TextInputType.emailAddress,
                controling: searchControl,
                label: "Search",
                preFixIcons: Icons.search,
                validatorFunc: (value) {
                  return null;
                },
                Onchange: (value) {
                  print(value);
                  cubit.searchData(value);
                },
              ),
            ),
            Expanded(child: buildArtical(list: cubit.search, context: context)),
          ]),
        );
      },
    );
  }
}
