import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_test_atto/domain/entities/product.dart';
import 'package:tech_test_atto/presentation/pages/page2_page.dart';
import 'package:tech_test_atto/presentation/provider/page1_notifier.dart';
import 'package:tech_test_atto/utils/state_enum.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  static const routeName = '/page1';

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<Page1Notifier>(
        context,
        listen: false,
      ).fetchProducts();
    });
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildProductList(List<Product> productList) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final product = productList[index];
        return Column(
          children: [
            if (index == 0)
              const SizedBox(
                height: 16,
              ),
            _buildProductCard(index, product),
            if (index != productList.length)
              const SizedBox(
                height: 16,
              ),
          ],
        );
      },
      itemCount: productList.length,
    );
  }

  Widget _buildError(String message) {
    return Center(
      key: const Key('error_message'),
      child: Text(message),
    );
  }

  Widget _buildProductCard(int index, Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        color: product.qty > 0 ? Colors.blue[100] : Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  product.name ?? '-',
                ),
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<Page1Notifier>(context, listen: false)
                          .subtractProductQty(index);
                    },
                    icon: const Icon(
                      Icons.remove,
                    ),
                  ),
                  Text(
                    product.qty.toString(),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<Page1Notifier>(context, listen: false)
                          .addProductQty(index);
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void directToPage2(List<Product> checkoutList) {
    Map<String, dynamic> arguments = {
      'checkoutList': checkoutList,
      'isPurchased': (bool status) {
        if (status) {
          Provider.of<Page1Notifier>(
            context,
            listen: false,
          ).fetchProducts();
        }
      }
    };

    Navigator.pushNamed(
      context,
      Page2.routeName,
      arguments: arguments,
    );
  }

  Widget _buildTotalCheckoutQty() {
    return Consumer<Page1Notifier>(
      builder: (context, data, child) {
        return Row(
          children: [
            const Text(
              'totalQty',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              data.totalQtyCheckoutList().toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChekoutButton() {
    return Consumer<Page1Notifier>(builder: (context, data, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextButton(
          onPressed: () {
            List<Product> checkoutList = data.checkoutMap.values.toList();
            directToPage2(checkoutList);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Checkout'),
                Text('${data.totalQtyCheckoutList()} Item')
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Page 1',
        ),
        actions: [
          _buildTotalCheckoutQty(),
          const SizedBox(width: 16),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Consumer<Page1Notifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.loading) {
            return _buildLoading();
          } else if (data.state == RequestState.loaded) {
            return _buildProductList(data.products);
          } else {
            return _buildError(data.message);
          }
        },
      ),
      floatingActionButton: _buildChekoutButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
