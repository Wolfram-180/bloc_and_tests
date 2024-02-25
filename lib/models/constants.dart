import 'dart:math' show Random;
import 'images_list.dart';

String get images =>
    'https://sdprompts.org/lib/pics/_sfw/${imagesList[Random().nextInt(imagesList.length)]}';
