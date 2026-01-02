import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';
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
  String? _selectedImagePath;
  String? _selectedVideoPath;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Post Problem',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form Section
            Expanded(
              flex: 2,
              child: Container(
                constraints: BoxConstraints(maxWidth: 600),
                padding: EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Field
                      Text(
                        'Problem Title',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _titleController,
                        maxLength: 100,
                        decoration: InputDecoration(
                          hintText: 'Clearly state the problem in one sentence',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(height: 24),

                      // Category Field
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
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
                      SizedBox(height: 24),

                      // Context Field
                      Text(
                        'Problem Context',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _contextController,
                        maxLength: 500,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Provide detailed context, background, and why this problem needs solving',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          alignLabelWithHint: true,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(height: 24),

                      // Media Upload Section
                      Text(
                        'Media (Optional)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _pickImage,
                              icon: Icon(Icons.image),
                              label: Text(_selectedImagePath != null ? 'Image Selected' : 'Add Image'),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                side: BorderSide(color: _selectedImagePath != null ? Colors.green : Colors.grey.shade300),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _pickVideo,
                              icon: Icon(Icons.videocam),
                              label: Text(_selectedVideoPath != null ? 'Video Selected' : 'Add Video'),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                side: BorderSide(color: _selectedVideoPath != null ? Colors.green : Colors.grey.shade300),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_selectedImagePath != null || _selectedVideoPath != null) ...[
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              if (_selectedImagePath != null) ...[
                                Icon(Icons.image, color: Colors.green),
                                SizedBox(width: 8),
                                Text('Image: ${_selectedImagePath!.split('/').last}'),
                                Spacer(),
                                IconButton(
                                  onPressed: () => setState(() => _selectedImagePath = null),
                                  icon: Icon(Icons.close, size: 16),
                                ),
                              ],
                              if (_selectedVideoPath != null) ...[
                                Icon(Icons.videocam, color: Colors.green),
                                SizedBox(width: 8),
                                Text('Video: ${_selectedVideoPath!.split('/').last}'),
                                Spacer(),
                                IconButton(
                                  onPressed: () => setState(() => _selectedVideoPath = null),
                                  icon: Icon(Icons.close, size: 16),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: 32),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isFormValid ? _submitProblem : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBackgroundColor: Colors.grey.shade300,
                          ),
                          child: Text(
                            'Post Problem',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Guidelines Section
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(24),
                margin: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Posting Guidelines',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildGuideline('Be specific and clear about the problem'),
                    _buildGuideline('Focus on the problem, not potential solutions'),
                    _buildGuideline('Provide enough context for others to understand'),
                    _buildGuideline('Avoid emotional language or blame'),
                    _buildGuideline('One problem per post'),
                    _buildGuideline('Choose the most relevant category'),
                    SizedBox(height: 24),
                    Text(
                      'Remember',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You cannot submit plans to your own problems. This ensures objective, unbiased solutions.',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideline(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(top: 6, right: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
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

  void _pickImage() {
    // Simulate file picker for web demo
    setState(() {
      _selectedImagePath = 'assets/images/sample_image.jpg';
      _selectedVideoPath = null;
    });
  }

  void _pickVideo() {
    // Simulate file picker for web demo
    setState(() {
      _selectedVideoPath = 'assets/videos/sample_video.mp4';
      _selectedImagePath = null;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contextController.dispose();
    super.dispose();
  }
}