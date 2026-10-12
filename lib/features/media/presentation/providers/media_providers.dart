import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/storage_repository.dart';

part 'media_providers.g.dart';

@riverpod
IStorageRepository storageRepository(Ref ref) {
  return SupabaseStorageRepository(Supabase.instance.client);
}

/// Holds state for active file uploads: status, upload progress (0.0 - 1.0), and result public URL
class UploadState {
  final bool isUploading;
  final double progress;
  final String? uploadedUrl;
  final String? error;

  const UploadState({
    this.isUploading = false,
    this.progress = 0.0,
    this.uploadedUrl,
    this.error,
  });

  UploadState copyWith({
    bool? isUploading,
    double? progress,
    String? uploadedUrl,
    String? error,
  }) {
    return UploadState(
      isUploading: isUploading ?? this.isUploading,
      progress: progress ?? this.progress,
      uploadedUrl: uploadedUrl ?? this.uploadedUrl,
      error: error ?? this.error,
    );
  }
}

@riverpod
class MediaController extends _$MediaController {
  @override
  UploadState build() {
    return const UploadState();
  }

  Future<String?> pickCompressAndUpload({
    required ImageSource source,
    required String bucketName,
    required String folderPath,
  }) async {
    final repository = ref.read(storageRepositoryProvider);

    try {
      // 1. Pick Image
      final XFile? pickedFile = await repository.pickImage(source: source);
      if (pickedFile == null) return null; // User cancelled picking

      state = state.copyWith(isUploading: true, progress: 0.0, error: null);

      // 2. Apply Lossy Compression
      final File originalFile = File(pickedFile.path);
      final File? compressedFile = await repository.compressImage(
        originalFile,
        quality: 75,
      );

      final File fileToUpload = compressedFile ?? originalFile;

      // 3. Upload to Supabase Storage with progress callbacks
      final String publicUrl = await repository.uploadMedia(
        file: fileToUpload,
        bucketName: bucketName,
        folderPath: folderPath,
      );

      state = state.copyWith(
        isUploading: false,
        progress: 1.0,
        uploadedUrl: publicUrl,
      );

      return publicUrl;
    } catch (e) {
      state = state.copyWith(
        isUploading: false,
        progress: 0.0,
        error: e.toString(),
      );
      return null;
    }
  }

  void reset() {
    state = const UploadState();
  }
}
