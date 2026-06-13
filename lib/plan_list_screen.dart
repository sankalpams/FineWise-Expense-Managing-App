import 'package:flutter/material.dart';
import 'mock_database.dart';
import 'expense_plan.dart';
import 'plan_form_screen.dart';

class PlanListScreen extends StatelessWidget {
  final String persona;
  final MockDatabase db = MockDatabase();

  PlanListScreen({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('$persona Plans'),
        backgroundColor: Colors.blue[100],
        foregroundColor: Colors.blue[900],
        elevation: 0,
      ),
      body: ValueListenableBuilder<List<ExpensePlan>>(
        valueListenable: db.plansNotifier,
        builder: (context, allPlans, child) {
          // Filter data for this specific screen profile
          final filteredPlans = db.readPlansByPersona(persona);

          if (filteredPlans.isEmpty) {
            return const Center(
              child: Text('No plans created yet. Tap + to start!'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredPlans.length,
            itemBuilder: (context, index) {
              final plan = filteredPlans[index];
              return Card(
                color: Colors.blue[50],
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    'Cash in Hand: \$${plan.cashInHand.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(plan.spendingPlan),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlanFormScreen(
                                persona: persona,
                                planToEdit: plan,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => db.deletePlan(plan.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[200],
        foregroundColor: Colors.blue[900],
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlanFormScreen(persona: persona),
            ),
          );
        },
      ),
    );
  }
}
