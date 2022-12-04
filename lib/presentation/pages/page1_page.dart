import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_test_atto/domain/entities/product.dart';
import 'package:tech_test_atto/presentation/provider/page1_notifier.dart';
import 'package:tech_test_atto/utils/state_enum.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  static const ROUTE_NAME = '/page1-page';

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
    return Center(
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
      key: Key('error_message'),
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
              SizedBox(width: 16),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<Page1Notifier>(context, listen: false)
                          .subtractProductQty(index);
                    },
                    icon: Icon(
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
                    icon: Icon(
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

  Widget _buildChekoutButton() {
    return TextButton(
      onPressed: () {},
      child: Row(
        children: [
          Icon(
            Icons.shopping_cart_sharp,
            color: Colors.white,
          ),
          SizedBox(
            width: 8,
          ),
          Consumer<Page1Notifier>(
            builder: (context, data, child) {
              return Text(
                data.totalQtyCheckoutList().toString(),
                style: TextStyle(color: Colors.white, fontSize: 20),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Page 1',
        ),
        actions: [
          _buildChekoutButton(),
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
    );
  }
}
