import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';
import '../utils/linkedin_theme.dart';

class SubmitPlanScreen extends StatefulWidget {
  final Problem problem;

  const SubmitPlanScreen({super.key, required this.problem});

  @override
  State<SubmitPlanScreen> createState() => _SubmitPlanScreenState();
}

class _SubmitPlanScreenState extends State<SubmitPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  bool get _isFormValid {
    return _descriptionController.text.trim().isNotEmpty &&
           _descriptionController.text.trim().length >= 50;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkedInTheme.backgroundGray,
      appBar: AppBar(
        backgroundColor: LinkedInTheme.cardWhite,
        elevation: 0,
        title: const Text('Submit Solution', style: LinkedInTheme.heading2),
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
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: LinkedInTheme.cardDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Problem Overview', style: LinkedInTheme.heading3),
                    const SizedBox(height: 12),
                    Text(
                      widget.problem.title,
                      style: LinkedInTheme.heading3,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.problem.context,
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
                    const Text('Your Solution *', style: LinkedInTheme.heading3),
                    const SizedBox(height: 8),
                    Text(
                      'Provide a detailed solution description (minimum 50 characters)',
                      style: LinkedInTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 8,
                      maxLength: 1000,
                      decoration: LinkedInTheme.inputDecoration(
                        'Describe your solution approach, implementation steps, and expected outcomes...',
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isFormValid ? _submitPlan : null,
                        style: LinkedInTheme.primaryButton,
                        child: const Text('Submit Solution', style: LinkedInTheme.buttonText),
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

  void _submitPlan() {
    if (_formKey.currentState!.validate() && _isFormValid) {
      final dataService = DataService();
      final plan = Plan(
        id: 'plan${DateTime.now().millisecondsSinceEpoch}',
        problemId: widget.problem.id,
        authorId: dataService.currentUserId,
        authorName: dataService.currentUserName,
        createdAt: DateTime.now(),
        steps: [
          PlanStep(
            title: 'Solution',
            description: _descriptionController.text.trim(),
          ),
        ],
      );

      dataService.addPlan(plan);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}