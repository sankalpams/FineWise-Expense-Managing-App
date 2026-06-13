
import 'package:flutter/material.dart';
import 'expense_plan.dart';
import 'mock_database.dart';

class PlanFormScreen extends StatefulWidget {
  final String persona;
  final ExpensePlan? planToEdit;

  const PlanFormScreen({super.key, required this.persona, this.planToEdit});

  @override
  State<PlanFormScreen> createState() => _PlanFormScreenState();
}

class _PlanFormScreenState extends State<PlanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cashController = TextEditingController();
  final _planController = TextEditingController();
  final db = MockDatabase();

  @override
  void initState() {
    super.initState();
    if (widget.planToEdit != null) {
      _cashController.text = widget.planToEdit!.cashInHand.toString();
      _planController.text = widget.planToEdit!.spendingPlan;
    }
  }

  @override
  void dispose() {
    _cashController.dispose();
    _planController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final plan = ExpensePlan(
      id: widget.planToEdit?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      persona: widget.persona,
      cashInHand: double.parse(_cashController.text),
      spendingPlan: _planController.text.trim(),
    );

    if (widget.planToEdit == null) {
      db.createPlan(plan);
    } else {
      db.updatePlan(plan);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.planToEdit != null;
    return Scaffold(
      appBar: AppBar(title: Text(editing ? 'Edit Plan' : 'Create Plan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _cashController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Cash in Hand'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter amount';
                  if (double.tryParse(v) == null) return 'Enter valid number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _planController,
                decoration: const InputDecoration(labelText: 'Spending Plan'),
                maxLines: 4,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter plan' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _save, child: Text(editing ? 'Update' : 'Create'))
            ],
          ),
        ),
      ),
    );
  }
}
