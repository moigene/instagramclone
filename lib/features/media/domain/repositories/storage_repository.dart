import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IStorageRepository {
  Future<XFile?> pickImage({required ImageSource source});
  Future<XFile?> pickVideo({required ImageSource source});
  Future<File?> compressImage(File file, {int quality = 80});
  Future<String> uploadMedia({
    required File file,
    required String bucketName,
    required String folderPath,
  });
}

class SupabaseStorageRepository implements IStorageRepository {
  final SupabaseClient _supabaseClient;
  final ImagePicker _picker;

  SupabaseStorageRepository(this._supabaseClient, [ImagePicker? picker])
    : _picker = picker ?? ImagePicker();

// Implementation of PickImage Method
  @override
  Future<XFile?> pickImage({required ImageSource source}) async {
    return await _picker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 100,
    );
  }

// Implementation of PickVideo Method
  @override
  Future<XFile?> pickVideo({required ImageSource source}) async {
    return await _picker.pickVideo(
      source: source,
      maxDuration: const Duration(seconds: 60),
    );
  }


// Implementation of CompressImage Method
  @override
  Future<File?> compressImage(File file, {int quality = 80}) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'\.(jpg|jpeg|png)'));
    final splitted = lastIndex != -1
        ? filePath.substring(0, lastIndex)
        : filePath;
    final outPath = "${splitted}_compressed.jpg";

    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      quality: quality,
      format: CompressFormat.jpeg,
    );

    if (result == null) return null;
    return File(result.path);
  }

// Implementation of UploadMedia Method
  @override
  Future<String> uploadMedia({
    required File file,
    required String bucketName,
    required String folderPath,
  }) async {
    final fileExt = p.extension(file.path);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}$fileExt';
    final fullStoragePath = '$folderPath/$fileName';

    // Standard binary upload to Supabase Storage
    await _supabaseClient.storage
        .from(bucketName)
        .upload(
          fullStoragePath,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    // Retrieve public URL for DB indexing
    final String publicUrl = _supabaseClient.storage
        .from(bucketName)
        .getPublicUrl(fullStoragePath);

    return publicUrl;
  }
}
