// lib/providers/web3_provider.dart
import 'package:flutter/foundation.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class Web3Provider with ChangeNotifier {
  final Web3Client _client;
  final String _contractAddress = "YOUR_CONTRACT_ADDRESS";
  Credentials? _credentials;
  bool _isConnected = false;

  Web3Provider({
    required Client httpClient,
    required String ethereumAddress,
  }) : _client = Web3Client(ethereumAddress, httpClient);

  bool get isConnected => _isConnected;
  Web3Client get client => _client;
  String get contractAddress => _contractAddress;

  Future<void> connectWallet() async {
    try {
      // Implement wallet connection logic (e.g., WalletConnect or MetaMask)
      // This is a placeholder for actual wallet connection code
      _isConnected = true;
      notifyListeners();
    } catch (e) {
      print('Error connecting wallet: $e');
      _isConnected = false;
      notifyListeners();
    }
  }

  Future<void> disconnectWallet() async {
    _isConnected = false;
    _credentials = null;
    notifyListeners();
  }

  Future<String> getBalance(String address) async {
    try {
      final balance = await _client.getBalance(EthereumAddress.fromHex(address));
      return balance.getValueInUnit(EtherUnit.ether).toString();
    } catch (e) {
      print('Error getting balance: $e');
      return '0';
    }
  }
}
