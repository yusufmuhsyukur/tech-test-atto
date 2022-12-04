import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_test_atto/domain/entities/product.dart';
import 'package:tech_test_atto/presentation/provider/page2_notifier.dart';
import 'package:tech_test_atto/utils/state_enum.dart';

class Page2 extends StatefulWidget {
  const Page2({
    super.key,
    required this.checkoutList,
    required this.isPurchased,
  });
  final List<Product> checkoutList;
  final Function(bool) isPurchased;

  static const ROUTE_NAME = '/page2';

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<Page2Notifier>(
        context,
        listen: false,
      ).setChekoutList(widget.checkoutList);
    });
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildProductList(List<Product> productList) {
    if (productList.isEmpty) {
      return Center(
        child: Text('Checkout List is Empty'),
      );
    }

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
      key: Key('error_message'),
      child: Text(message),
    );
  }

  Widget _buildProductCard(int index, Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  product.name ?? '-',
                ),
              ),
              SizedBox(width: 16),
              Row(
                children: [
                  Text(
                    product.qty.toString(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalCheckoutQty() {
    return Consumer<Page2Notifier>(
      builder: (context, data, child) {
        return Row(
          children: [
            Text(
              'totalQty',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              data.totalQtyCheckoutList().toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _builPurchaseButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: () {
          widget.isPurchased(true);
          Navigator.pop(context);
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Buy'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Page 2',
        ),
        actions: [
          _buildTotalCheckoutQty(),
          SizedBox(width: 16),
        ],
        automaticallyImplyLeading: true,
      ),
      body: Consumer<Page2Notifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.loading) {
            return _buildLoading();
          } else if (data.state == RequestState.loaded) {
            return _buildProductList(data.checkoutList);
          } else {
            return _buildError(data.message);
          }
        },
      ),
      floatingActionButton:
          widget.checkoutList.isNotEmpty ? _builPurchaseButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
