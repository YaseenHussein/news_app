import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/moduls/web_view/web_view.dart';

import '../../cubit/cubit.dart';

Widget buildSpr() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20,
      ),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );
Widget buildArtical({list, context}) {
  return ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildNews(list[index], context),
      separatorBuilder: (context, index) => buildSpr(),
      itemCount: list.length,
    ),
    fallback: (context) => Center(child: CircularProgressIndicator()),
  );
}

Widget buildNews(var listBusiness, context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => WebScreen(listBusiness['url']))));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: listBusiness['urlToImage'] == null
                    ? NetworkImage(
                        'https://t3.ftcdn.net/jpg/05/62/05/12/360_F_562051283_m5uNbG6GNbSWSv6thCxvegPaprT5o2hw.jpg')
                    : NetworkImage('${listBusiness['urlToImage']}'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsetsDirectional.only(start: 10),
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${listBusiness['title']}",
                      style: TextStyle(
                        color: AppNewsCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${listBusiness['publishedAt']}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget defaultTextInput({
  required TextEditingController controling,
  required String? Function(String?) validatorFunc,
  Function? IconFun,
  Function(String)? Onchange,
  Function(String)? OnFileSubite,
  required String label,
  bool isPassword = false,
  required IconData preFixIcons,
  IconData? suffixIcons,
  double radius = 10,
  Function()? onTap,
  TextInputType typeKeybord = TextInputType.emailAddress,
}) =>
    TextFormField(
      obscureText: isPassword,
      keyboardType: typeKeybord,
      controller: controling,
      validator: validatorFunc,
      onFieldSubmitted: OnFileSubite,
      onChanged: Onchange,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(preFixIcons),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        suffixIcon: suffixIcons != null
            ? IconButton(
                onPressed: () {
                  IconFun!();
                },
                icon: Icon(suffixIcons))
            : null,
      ),
    );
