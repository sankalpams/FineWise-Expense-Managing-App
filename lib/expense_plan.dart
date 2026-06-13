class ExpensePlan {
  final String id;
  final String persona; // Gen Z, Employee, Businessman, Adult
  final double cashInHand;
  final String spendingPlan;

  ExpensePlan({
    required this.id,
    required this.persona,
    required this.cashInHand,
    required this.spendingPlan,
  });

  // Helper method to copy/clone an object when updating it
  ExpensePlan copyWith({
    String? id,
    String? persona,
    double? cashInHand,
    String? spendingPlan,
  }) {
    return ExpensePlan(
      id: id ?? this.id,
      persona: persona ?? this.persona,
      cashInHand: cashInHand ?? this.cashInHand,
      spendingPlan: spendingPlan ?? this.spendingPlan,
    );
  }
}
