library providers;

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'package:beamer/beamer.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_scanner/locations/locations.dart';
import 'package:text_scanner/utils/shared_data.dart';

part 'common.dart';
part 'providers.g.dart';
part 'images.dart';
part 'text_rec.dart';
