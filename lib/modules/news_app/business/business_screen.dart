import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:centre_for_training/layout/news_app/cubit/cubit.dart';
import 'package:centre_for_training/layout/news_app/cubit/states.dart';
import 'package:centre_for_training/shared/components/components.dart';
import 'package:centre_for_training/shared/cubit/cubit.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;

        return articleBuilder(list, context);
      },
    );
  }
}
