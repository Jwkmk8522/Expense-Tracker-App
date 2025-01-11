import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.spendingAmount,
    required this.label,
    required this.spendingPcOfTotal,
  });
  final double spendingAmount;
  final double spendingPcOfTotal;
  final String label;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
                height: constraints.maxHeight * 0.12,
                child: FittedBox(
                    child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.66,
              width: 30,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.0),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPcOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
                height: constraints.maxHeight * 0.12,
                child: FittedBox(child: Text(label))),
          ],
        );
      },
    );
  }
}
