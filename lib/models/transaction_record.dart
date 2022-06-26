class TransactionRecord {
  final String token;
  final String units;
  final bool passed;
  final String message;
  final String meterNumber;
  final String meterName;
  final int date;
  final String priceGross;
  final String priceNet;
  final String debt;
  final String vat;
  final String serviceCharge;
  final String txnReference;
  final String receiptID;
  final String freeUnits;
  final String paymentType;
  final String username;
  final String address;
  final String meterCategory;

  const TransactionRecord({
    required this.token,
    required this.units,
    required this.passed,
    required this.message,
    required this.meterNumber,
    required this.meterName,
    required this.date,
    required this.priceGross,
    required this.priceNet,
    required this.debt,
    required this.vat,
    required this.serviceCharge,
    required this.txnReference,
    required this.receiptID,
    required this.freeUnits,
    required this.paymentType,
    required this.username,
    required this.address,
    required this.meterCategory,
  });

  TransactionRecord.fromMap(Map record)
      : txnReference = record['txnReference'],
        token = record['token'],
        units = record['units'],
        passed = record['passed'],
        message = record['message'],
        meterNumber = record['meterNumber'],
        meterName = record['meterName'],
        date = record['date'],
        priceGross = record['priceGross'],
        priceNet = record['priceNet'],
        debt = record['debt'],
        vat = record['vat'],
        serviceCharge = record['serviceCharge'],
        receiptID = record['receiptID'],
        freeUnits = record['freeUnits'],
        paymentType = record['paymentType'],
        username = record['username'],
        address = record['address'],
        meterCategory = record['meterCategory'];
}
