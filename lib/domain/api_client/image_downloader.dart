import '../../configuration/configuration.dart';

class ImageDownloader {
  String imageUrl(String path) => Configuration.imageUrl + path;
}