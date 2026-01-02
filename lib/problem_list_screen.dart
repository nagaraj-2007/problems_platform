import 'package:flutter/material.dart';
import 'data_service.dart';
import 'components.dart';
import 'problem_preview_screen.dart';

class ProblemListScreen extends StatefulWidget {
  const ProblemListScreen({super.key});

  @override
  State<ProblemListScreen> createState() => _ProblemListScreenState();
}

class _ProblemListScreenState extends State<ProblemListScreen> {
  String selectedCategory = 'All';
  String sortBy = 'Newest';

  final sortOptions = ['Newest', 'Most Plans'];

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    var problems = dataService.getProblems();
    final categories = ['All', ...DataService.categories];

    // Filter by category
    if (selectedCategory != 'All') {
      problems = problems.where((p) => p.category == selectedCategory).toList();
    }

    // Sort
    if (sortBy == 'Most Plans') {
      problems.sort((a, b) => b.planCount.compareTo(a.planCount));
    } else {
      problems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.1),
        title: const Text(
          'Problems',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Enhanced Filter Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  // Category Filter
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(
                              category,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF0F172A),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        underline: Container(),
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Sort Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.sort,
                          size: 16,
                          color: Color(0xFF6366F1),
                        ),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: sortBy,
                          onChanged: (value) {
                            setState(() {
                              sortBy = value!;
                            });
                          },
                          items: sortOptions.map((option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(
                                option,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF0F172A),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          underline: Container(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF6366F1),
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Problems List
            Expanded(
              child: problems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.search_off,
                              size: 48,
                              color: Color(0xFF6366F1),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'No problems found',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            selectedCategory != 'All' 
                                ? 'Try selecting a different category'
                                : 'Be the first to post a problem!',
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                            ),
                          ),
                          if (selectedCategory != 'All') ...[
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedCategory = 'All';
                                });
                              },
                              child: const Text('Show all categories'),
                            ),
                          ],
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: problems.length,
                      itemBuilder: (context, index) {
                        final problem = problems[index];
                        return ProblemCard(
                          problem: problem,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProblemPreviewScreen(problemId: problem.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}