import 'package:flutter/material.dart';
import 'expense_plan.dart';

class MockDatabase {
  // Singleton pattern so the entire app shares the same data source
  static final MockDatabase _instance = MockDatabase._internal();
  factory MockDatabase() => _instance;
  MockDatabase._internal();

  // ValueNotifier alerts the UI whenever items are added, updated, or deleted
  final ValueNotifier<List<ExpensePlan>> plansNotifier =
      ValueNotifier<List<ExpensePlan>>([]);

  // 1. CREATE
  void createPlan(ExpensePlan plan) {
    final currentList = List<ExpensePlan>.from(plansNotifier.value);
    currentList.add(plan);
    plansNotifier.value = currentList;
  }

  // 2. READ (Filtered by Persona category)
  List<ExpensePlan> readPlansByPersona(String persona) {
    return plansNotifier.value
        .where((plan) => plan.persona == persona)
        .toList();
  }

  // 3. UPDATE
  void updatePlan(ExpensePlan updatedPlan) {
    final currentList = List<ExpensePlan>.from(plansNotifier.value);
    final index = currentList.indexWhere((plan) => plan.id == updatedPlan.id);
    if (index != -1) {
      currentList[index] = updatedPlan;
      plansNotifier.value = currentList; // Triggers UI update
    }
  }

  // 4. DELETE
  void deletePlan(String id) {
    final currentList = List<ExpensePlan>.from(plansNotifier.value);
    currentList.removeWhere((plan) => plan.id == id);
    plansNotifier.value = currentList;
  }
}
