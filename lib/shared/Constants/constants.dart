// ignore_for_file: avoid_print


import '../../modules/shop_app/log_in/logIn_screen.dart';
import '../components/taskCard.dart';
import '../network/local/cache_helper.dart';

void logOut(context){
            
            CacheHelper.removeData(key: 'token').then((value) {
              if (value) navigateAndFinish(context, LogIn_Screen());
            });
          
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) =>print(match.group(0)));
}

String token='' ;