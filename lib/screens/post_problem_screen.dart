import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/models.dart';
import '../services/data_service.dart';
import '../utils/linkedin_theme.dart';
import '../widgets/searchable_dropdown.dart';

class PostProblemScreen extends StatefulWidget {
  const PostProblemScreen({super.key});

  @override
  State<PostProblemScreen> createState() => _PostProblemScreenState();
}

class _PostProblemScreenState extends State<PostProblemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contextController = TextEditingController();
  String? _selectedCategory;
  File? _selectedImage;
  File? _selectedVideo;
  String? _selectedImagePath;
  String? _selectedVideoPath;
  final ImagePicker _picker = ImagePicker();

  bool get _isFormValid {
    return _titleController.text.trim().isNotEmpty &&
           _contextController.text.trim().isNotEmpty &&
           _selectedCategory != null &&
           _titleController.text.length <= 100 &&
           _contextController.text.length <= 500;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkedInTheme.backgroundGray,
      appBar: AppBar(
        backgroundColor: LinkedInTheme.cardWhite,
        elevation: 0,
        title: const Text('Post Problem', style: LinkedInTheme.heading2),
        iconTheme: const IconThemeData(color: LinkedInTheme.textPrimary),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: LinkedInTheme.borderGray),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: LinkedInTheme.cardDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Share a Problem', style: LinkedInTheme.heading1),
                    const SizedBox(height: 8),
                    Text(
                      'Help the community by sharing a problem that needs solving.',
                      style: LinkedInTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: LinkedInTheme.cardDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Problem Title *', style: LinkedInTheme.heading3),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _titleController,
                      maxLength: 100,
                      decoration: LinkedInTheme.inputDecoration(
                        'Clearly describe the problem in one sentence',
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 20),
                    const Text('Category *', style: LinkedInTheme.heading3),
                    const SizedBox(height: 8),
                    SearchableDropdown(
                      items: DataService.categories,
                      value: _selectedCategory,
                      hintText: 'Select a category',
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Problem Context *', style: LinkedInTheme.heading3),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _contextController,
                      maxLength: 500,
                      maxLines: 6,
                      decoration: LinkedInTheme.inputDecoration(
                        'Provide detailed context and background information',
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 20),
                    const Text('Media (Optional)', style: LinkedInTheme.heading3),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _showImageSourceDialog(),
                            icon: const Icon(Icons.image, size: 18),
                            label: Text(_selectedImagePath != null ? 'Image Selected' : 'Add Image'),
                            style: LinkedInTheme.secondaryButton.copyWith(
                              foregroundColor: WidgetStateProperty.all(
                                _selectedImagePath != null ? LinkedInTheme.successGreen : LinkedInTheme.primaryBlue,
                              ),
                              side: WidgetStateProperty.all(
                                BorderSide(
                                  color: _selectedImagePath != null ? LinkedInTheme.successGreen : LinkedInTheme.primaryBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _showVideoSourceDialog(),
                            icon: const Icon(Icons.videocam, size: 18),
                            label: Text(_selectedVideoPath != null ? 'Video Selected' : 'Add Video'),
                            style: LinkedInTheme.secondaryButton.copyWith(
                              foregroundColor: WidgetStateProperty.all(
                                _selectedVideoPath != null ? LinkedInTheme.successGreen : LinkedInTheme.primaryBlue,
                              ),
                              side: WidgetStateProperty.all(
                                BorderSide(
                                  color: _selectedVideoPath != null ? LinkedInTheme.successGreen : LinkedInTheme.primaryBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_selectedImagePath != null || _selectedVideoPath != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: LinkedInTheme.backgroundGray,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            if (_selectedImagePath != null) ...[
                              const Icon(Icons.image, color: LinkedInTheme.successGreen, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Image: ${_selectedImagePath!.split('/').last}',
                                  style: LinkedInTheme.bodySmall,
                                ),
                              ),
                              IconButton(
                                onPressed: () => setState(() {
                                  _selectedImagePath = null;
                                  _selectedImage = null;
                                }),
                                icon: const Icon(Icons.close, size: 16),
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                            if (_selectedVideoPath != null) ...[
                              const Icon(Icons.videocam, color: LinkedInTheme.successGreen, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Video: ${_selectedVideoPath!.split('/').last}',
                                  style: LinkedInTheme.bodySmall,
                                ),
                              ),
                              IconButton(
                                onPressed: () => setState(() {
                                  _selectedVideoPath = null;
                                  _selectedVideo = null;
                                }),
                                icon: const Icon(Icons.close, size: 16),
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isFormValid ? _submitProblem : null,
                        style: LinkedInTheme.primaryButton,
                        child: const Text('Post Problem', style: LinkedInTheme.buttonText),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitProblem() {
    if (_formKey.currentState!.validate() && _isFormValid) {
      final dataService = DataService();
      final problem = Problem(
        id: 'p${DateTime.now().millisecondsSinceEpoch}',
        title: _titleController.text.trim(),
        category: _selectedCategory!,
        context: _contextController.text.trim(),
        authorId: dataService.currentUserId,
        authorName: dataService.currentUserName,
        createdAt: DateTime.now(),
        imageUrl: _selectedImagePath,
        videoUrl: _selectedVideoPath,
      );

      dataService.addProblem(problem);
      Navigator.pop(context);
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showVideoSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickVideo(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickVideo(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _selectedImagePath = image.path;
          _selectedVideo = null;
          _selectedVideoPath = null;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _pickVideo(ImageSource source) async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: source,
      );
      if (video != null) {
        setState(() {
          _selectedVideo = File(video.path);
          _selectedVideoPath = video.path;
          _selectedImage = null;
          _selectedImagePath = null;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking video: $e')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contextController.dispose();
    super.dispose();
  }
}