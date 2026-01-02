import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';

class SubmitPlanScreen extends StatefulWidget {
  final Problem problem;

  const SubmitPlanScreen({super.key, required this.problem});

  @override
  State<SubmitPlanScreen> createState() => _SubmitPlanScreenState();
}

class _SubmitPlanScreenState extends State<SubmitPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  List<StepController> _steps = [];

  @override
  void initState() {
    super.initState();
    // Start with 3 empty steps
    _steps = List.generate(3, (index) => StepController());
  }

  bool get _isFormValid {
    return _steps.length >= 3 &&
           _steps.every((step) => 
               step.titleController.text.trim().isNotEmpty &&
               step.descriptionController.text.trim().isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Submit Plan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Problem Summary
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 32),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Problem:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.problem.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      widget.problem.context,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Plan Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Plan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Create a step-by-step plan to solve this problem. Minimum 3 steps required.',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 24),

                    // Steps
                    ..._steps.asMap().entries.map((entry) {
                      final index = entry.key;
                      final step = entry.value;
                      return _buildStepCard(index, step);
                    }),

                    // Add Step Button
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 32),
                      child: OutlinedButton.icon(
                        onPressed: _addStep,
                        icon: Icon(Icons.add),
                        label: Text('Add Step'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isFormValid ? _submitPlan : null,
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
                          'Submit Plan (${_steps.length} steps)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepCard(int index, StepController step) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Step ${index + 1}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (_steps.length > 3)
                  IconButton(
                    onPressed: () => _removeStep(index),
                    icon: Icon(Icons.close, color: Colors.grey.shade600),
                    constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
                  ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: step.titleController,
              decoration: InputDecoration(
                labelText: 'Step Title',
                hintText: 'What needs to be done?',
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
            SizedBox(height: 16),
            TextFormField(
              controller: step.descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Step Description',
                hintText: 'Provide details on how to execute this step',
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
          ],
        ),
      ),
    );
  }

  void _addStep() {
    setState(() {
      _steps.add(StepController());
    });
  }

  void _removeStep(int index) {
    if (_steps.length > 3) {
      setState(() {
        _steps[index].dispose();
        _steps.removeAt(index);
      });
    }
  }

  void _submitPlan() {
    if (_formKey.currentState!.validate() && _isFormValid) {
      final dataService = DataService();
      final planSteps = _steps.map((step) => PlanStep(
        title: step.titleController.text.trim(),
        description: step.descriptionController.text.trim(),
      )).toList();

      final plan = Plan(
        id: 'plan${DateTime.now().millisecondsSinceEpoch}',
        problemId: widget.problem.id,
        authorId: dataService.currentUserId,
        authorName: dataService.currentUserName,
        steps: planSteps,
        createdAt: DateTime.now(),
      );

      dataService.addPlan(plan);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    for (final step in _steps) {
      step.dispose();
    }
    super.dispose();
  }
}

class StepController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
  }
}