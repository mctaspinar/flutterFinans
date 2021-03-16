import 'package:flutter/material.dart';
import 'package:flutter_finans/models/expense.dart';

class TransactionItem extends StatelessWidget {
  final Expense itemOfExpense;
  const TransactionItem(this.itemOfExpense);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: itemOfExpense.color.withOpacity(.8),
              borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.center,
          child: Icon(
            itemOfExpense.category == 'Giyim'
                ? Icons.person
                : itemOfExpense.category == 'Market'
                    ? Icons.shopping_bag
                    : Icons.battery_unknown,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Text(
          itemOfExpense.category,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          itemOfExpense.subtitle,
          style: TextStyle(fontSize: 12),
        ),
        trailing: Text(
          '₺${itemOfExpense.value}',
          style: TextStyle(fontSize: 12, color: Colors.red),
        ),
      ),
    );
  }
}
