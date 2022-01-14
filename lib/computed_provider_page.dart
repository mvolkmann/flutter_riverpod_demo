import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final priceStateProvider = StateProvider<double>((ref) => 100);
final taxStateProvider = StateProvider<double>((ref) => 0.075);
final totalStateProvider = StateProvider<double>((ref) {
  final price = ref.watch(priceStateProvider);
  final tax = ref.watch(taxStateProvider);
  return price * (1 + tax);
});

class ComputedProviderPage extends ConsumerWidget {
  static const route = '/scoped-provider';

  ComputedProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final price = ref.watch(priceStateProvider);
    final tax = ref.watch(taxStateProvider);
    final total = ref.watch(totalStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('ComputedProvider Demo'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                ),
                initialValue: price.toString(),
                keyboardType: TextInputType.number,
                onChanged: (String value) => setPrice(ref, double.parse(value)),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tax',
                ),
                initialValue: tax.toString(),
                keyboardType: TextInputType.number,
                onChanged: (String value) => setTax(ref, double.parse(value)),
              ),
              SizedBox(height: 10),
              Text('Total: \$${total.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }

  void setPrice(ref, price) {
    ref.read(priceStateProvider.state).state = price;
  }

  void setTax(ref, tax) {
    ref.read(taxStateProvider.state).state = tax;
  }
}
