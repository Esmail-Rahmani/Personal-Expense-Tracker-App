
import 'dart:io';

import '../routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
enum RouteTypes { push, resetTo, pop, replace, resetAndPush }
bool canExit = false;

Future<void> route(RouteTypes type, [path, arguments]) async{

  switch (type) {
    case RouteTypes.push:
      await navigatorKey.currentState?.pushNamed(path, arguments: arguments ?? {});
      break;
    case RouteTypes.replace:
      navigatorKey.currentState?.pushReplacementNamed(path, arguments: arguments ?? {});
      break;
    case RouteTypes.resetTo:
      navigatorKey.currentState?.pushNamedAndRemoveUntil(path, (Route<dynamic> route) => false, arguments: arguments ?? {});
      break;
    case RouteTypes.resetAndPush:
      navigatorKey.currentState?.pushNamedAndRemoveUntil(rootRoute, (Route<dynamic> route) => false);
      // navigatorKey.currentState?.pushNamed(pinRoute, arguments: arguments ?? {});
      navigatorKey.currentState?.pushNamed(path, arguments: arguments ?? {});
      break;
    case RouteTypes.pop:
      bool canPop = navigatorKey.currentState?.canPop()??false;
      // developerMsg("Pop called", "Pop Status $canPop\nCan Exit $canExit");
      if (canPop == true) {
        navigatorKey.currentState?.pop();
        navigatorKey.currentState?.popUntil((route) {
          String? routeName = route.settings.name;
          // cardProvider.setCurrentActiveRoute(routeName ?? '');
          return true;
        });
      } else {
        if(canExit){
          //cardProvider.setJwt('');
          //await localCache.write(jwtSessionKey, "");
          if(Platform.isAndroid) {
            SystemChannels.platform.invokeMethod<void>(
                'SystemNavigator.pop', true);
          }else {
            exit(0);
          }
        }else{
          canExit = true;

        }
      }
      break;
    default:
      break;
  }
}