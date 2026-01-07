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
  
  final List<XFile> _selectedImages = [];
  final List<XFile> _selectedVideos = [];
  
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
                      validator: (value) {
                         if (value == null || value.trim().isEmpty) return 'Title is required';
                         return null;
                      },
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
                      validator: (value) {
                         if (value == null || value.trim().isEmpty) return 'Context is required';
                         return null;
                      },
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 20),
                    const Text('Media (Optional)', style: LinkedInTheme.heading3),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _pickImages(),
                            icon: const Icon(Icons.image, size: 18),
                            label: const Text('Add Images'),
                            style: LinkedInTheme.secondaryButton.copyWith(
                              foregroundColor: WidgetStateProperty.all(LinkedInTheme.primaryBlue),
                              side: WidgetStateProperty.all(const BorderSide(color: LinkedInTheme.primaryBlue)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _pickVideo(),
                            icon: const Icon(Icons.videocam, size: 18),
                            label: const Text('Add Video'),
                            style: LinkedInTheme.secondaryButton.copyWith(
                              foregroundColor: WidgetStateProperty.all(LinkedInTheme.primaryBlue),
                              side: WidgetStateProperty.all(const BorderSide(color: LinkedInTheme.primaryBlue)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    if (_selectedImages.isNotEmpty || _selectedVideos.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      // Images List
                      if (_selectedImages.isNotEmpty) ...[
                        const Text('Selected Images:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: FileImage(File(_selectedImages[index].path)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 4,
                                    top: 4,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedImages.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.close, color: Colors.white, size: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      // Videos List
                      if (_selectedVideos.isNotEmpty) ...[
                        const Text('Selected Videos:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(height: 8),
                        Column(
                          children: _selectedVideos.asMap().entries.map((entry) {
                            final index = entry.key;
                            final video = entry.value;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: LinkedInTheme.backgroundGray,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.videocam, color: LinkedInTheme.primaryBlue),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Video ${index + 1}: ${video.name}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: LinkedInTheme.bodySmall,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        _selectedVideos.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
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
        imageUrls: _selectedImages.map((e) => e.path).toList(),
        videoUrls: _selectedVideos.map((e) => e.path).toList(),
      );

      dataService.addProblem(problem);
      Navigator.pop(context);
    }
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking images: $e')),
      );
    }
  }

  Future<void> _pickVideo() async {
    try {
      // Pick a single video and add to list
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
      );
      if (video != null) {
        setState(() {
          _selectedVideos.add(video);
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