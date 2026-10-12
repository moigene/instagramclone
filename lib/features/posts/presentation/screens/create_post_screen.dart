import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../media/presentation/providers/media_providers.dart';
import '../providers/post_providers.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _captionController = TextEditingController();
  String? _uploadedMediaUrl;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadMedia(ImageSource source) async {
    final publicUrl = await ref
        .read(mediaControllerProvider.notifier)
        .pickCompressAndUpload(
          source: source,
          bucketName: 'posts',
          folderPath: 'user_uploads',
        );

    if (publicUrl != null) {
      setState(() {
        _uploadedMediaUrl = publicUrl;
      });
    }
  }

  Future<void> _submitPost() async {
    if (_uploadedMediaUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    final success = await ref
        .read(postControllerProvider.notifier)
        .createPost(
          caption: _captionController.text,
          mediaUrl: _uploadedMediaUrl!,
        );

    if (mounted) {
      if (success) {
        ref.read(mediaControllerProvider.notifier).reset();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post published successfully!')),
        );
        context.pop();
      } else {
        final error = ref.read(postControllerProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error?.toString().replaceAll('Exception: ', '') ??
                  'Failed to create post',
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaState = ref.watch(mediaControllerProvider);
    final postState = ref.watch(postControllerProvider);

    final bool isProcessing = mediaState.isUploading || postState.isLoading;

    return PopScope(
      canPop: !isProcessing,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Post'),
          actions: [
            TextButton(
              onPressed: isProcessing || _uploadedMediaUrl == null
                  ? null
                  : _submitPost,
              child: postState.isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'Share',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
          ],
        ),  
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: isProcessing
                    ? null
                    : () => _showMediaSourceDialog(context),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: _uploadedMediaUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              _uploadedMediaUrl!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : mediaState.isUploading
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 12),
                              Text('Compressing & Uploading...'),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 56,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 8),
                              const Text('Tap to select photo'),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _captionController,
                maxLines: 4,
                enabled: !isProcessing,
                decoration: const InputDecoration(
                  hintText: 'Write a caption...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMediaSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickAndUploadMedia(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickAndUploadMedia(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
