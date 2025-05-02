import 'package:flutter/material.dart';
import 'package:grabai/features/face_scan/presentation/screens/face_scan_screen.dart';
import 'package:grabai/features/settings/presentation/screens.dart';
import 'package:grabai/features/stats/presentation/screens/stats_screen.dart';
import 'package:grabai/features/home/presentation/screens/home_screen.dart';
import 'package:grabai/features/fines/presentation/screens/fine_detail_screen.dart';
import 'package:grabai/features/add_data/presentation/screens/add_user_screen.dart';

class AppRouter {
  static const String initialRoute = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/face-scan':
        return MaterialPageRoute(builder: (_) => const FaceScanScreen());
      case '/stats':
        return MaterialPageRoute(builder: (_) => const StatsScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/add-user':
        return MaterialPageRoute(builder: (_) => const AddUserScreen());
      case '/fine-detail':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => FineDetailScreen(
                imageUrl: args['imageUrl'],
                date: args['date'],
                time: args['time'],
                location: args['location'],
                isPaid: args['isPaid'],
                personId: args['personId'],
              ),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('404 - Page not found')),
              ),
        );
    }
  }
}
