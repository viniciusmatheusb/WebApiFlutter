import 'package:web_api/models/contact.dart';
import 'package:web_api/models/transactions.dart';
import 'package:flutter/material.dart';

import '../components/progressBar.dart';
import '../http/webClient.dart';

class TransactionsList extends StatelessWidget {
  final List<Transactions> transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: FutureBuilder<List<Transactions>>(
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Transactions> transactions = snapshot.requireData;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Transactions transaction = transactions[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.monetization_on),
                      title: Text(
                        transaction.value.toString(),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        transaction.contact.accountNumber.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              );
              break;
          }
          return Text('Unknown error');
        },
      ),
    );
  }
}
