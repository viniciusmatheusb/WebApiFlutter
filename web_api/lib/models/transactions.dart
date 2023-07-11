import 'contact.dart';

class Transactions {
  final double value;
  final Contact contact;

  Transactions(
    this.value,
    this.contact,
  );

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }
}
