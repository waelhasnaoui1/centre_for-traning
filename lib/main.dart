import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../screens/welcome_screen.dart';
import 'package:centre_for_training/layout/news_app/cubit/cubit.dart';
import 'package:centre_for_training/layout/news_app/news_layout.dart';
import 'package:centre_for_training/layout/shop_app/cubit/cubit.dart';
import 'package:centre_for_training/layout/shop_app/shop_layout.dart';
import 'package:centre_for_training/layout/social_app/cubit/cubit.dart';
import 'package:centre_for_training/layout/social_app/social_layout.dart';
import 'package:centre_for_training/modules/shop_app/login/shop_login_screen.dart';
import 'package:centre_for_training/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:centre_for_training/modules/social_app/social_login/social_login_screen.dart';
import 'package:centre_for_training/modules/social_app/social_register/social_register_screen.dart';
import 'package:centre_for_training/shared/bloc_observer.dart';
import 'package:centre_for_training/shared/components/constants.dart';
import 'package:centre_for_training/shared/cubit/cubit.dart';
import 'package:centre_for_training/shared/cubit/states.dart';
import 'package:centre_for_training/shared/network/local/cache_helper.dart';
import 'package:centre_for_training/shared/network/remote/dio_helper.dart';
import 'package:centre_for_training/shared/styles/themes.dart';


void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;


  //bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  //token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');

  // if(onBoarding != null)
  // {
  //   if(token != null) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // } else
  //   {
  //     widget = OnBoardingScreen();
  //   }

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool isDark;
  final Widget startWidget;

  MyApp({
   this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getUserData()
            ..getPosts()
            ..getUsers(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
            AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            initialRoute:WelcomeScreen.id,
            routes: {
             // Login.id: (context) => Login (),
             // Register.id:(context) =>Register(),
             // MainScreen.id:(context) => MainScreen(),
              WelcomeScreen.id:(context) => WelcomeScreen(),
              SocialRegisterScreen.id:(context)=>SocialRegisterScreen()

            },
          );
        },
      ),
    );
  }
}

// ./gradlew signingReport
