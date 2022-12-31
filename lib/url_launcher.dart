import 'package:url_launcher/url_launcher.dart';

class Url{
  
  Future <void> url(scheme, path)async{
  final Uri LaunchUri = Uri(
  scheme: scheme,
  path: path,
);
  await launchUrl(LaunchUri);
}
}