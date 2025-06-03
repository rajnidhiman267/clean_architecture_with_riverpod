import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msc_suite_flutter_app/features/product_dummy/presentation/provider/product_provider.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final productsAsync = ref.watch(productsProvider);
    final stringvalue = ref.watch(stringvalueProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Text(stringvalue),
      // productsAsync.when(
      //   data: (products) {
      //     return ListView.builder(
      //       itemCount: products.length,
      //       itemBuilder: (context, index) {
      //         final product = products[index];
      //         return ListTile(
      //           leading: Text('${product.id}'),
      //           title: Text(product.title),
      //         );
      //       },
      //     );
      //   },
      //   loading: () => const Center(child: CircularProgressIndicator()),
      //   error: (error, stack) => Center(child: Text('Error: $error')),
      // ),
    );
  }
}
