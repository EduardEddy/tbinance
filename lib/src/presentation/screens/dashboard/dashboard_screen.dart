import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_binance/src/presentation/providers/user/user_provider.dart';
import 'package:test_binance/src/presentation/screens/dashboard/widget/chart_widget.dart';
import 'package:web_socket_channel/io.dart';

class DashboardScreen extends StatefulWidget {
  static String name = 'dashboard';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String btcUsdtPrice = "0.0";
  String ethUsdtPrice = "0.0";
  String bnbUsdtPrice = "0.0";
  String cantBtc = "0.0";
  String cantEth = "0.0";
  String cantBnb = "0.0";
  final channel = IOWebSocketChannel.connect(
    'wss://stream.binance.com:9443/ws/btcusdt@trade',
  );
  final channelEth = IOWebSocketChannel.connect(
    'wss://stream.binance.com:9443/ws/ethusdt@trade',
  );
  final channelBNB = IOWebSocketChannel.connect(
    'wss://stream.binance.com:9443/ws/bnbusdt@trade',
  );
  @override
  void initState() {
    super.initState();
    streamListener();
  }

  streamListener() {
    channel.stream.listen((message) {
      Map getData = jsonDecode(message);
      setState(() {
        btcUsdtPrice = getData['p'];
        cantBtc = getData['q'];
      });
    });
    channelEth.stream.listen((message) {
      Map getData = jsonDecode(message);
      setState(() {
        ethUsdtPrice = getData['p'];
        cantEth = getData['q'];
      });
    });
    channelBNB.stream.listen((message) {
      Map getData = jsonDecode(message);
      setState(() {
        bnbUsdtPrice = getData['p'];
        cantBnb = getData['q'];
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    channelEth.sink.close();
    channelBNB.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();
    final mail = userProvider.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transacciones en Linea',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              context.go('/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 5),
                child: _TextTitle(title: "Hola: $mail"),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_TextTitle(title: "Precio de las criptomonedas")],
            ),
            ChartWidget(
              btc: btcUsdtPrice,
              eth: ethUsdtPrice,
              bnb: bnbUsdtPrice,
              limit: 100000,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TextTitle(title: 'Cantidad de criptomonedas transferidas')
              ],
            ),
            ChartWidget(
              btc: cantBtc,
              eth: cantEth,
              bnb: cantBnb,
              limit: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class _TextTitle extends StatelessWidget {
  final String title;
  const _TextTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF022B3A),
      ),
    );
  }
}
