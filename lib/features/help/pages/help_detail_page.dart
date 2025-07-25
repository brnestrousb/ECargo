import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpDetailPage extends StatefulWidget {
  const HelpDetailPage({super.key});

  @override
  State<HelpDetailPage> createState() => _HelpDetailPageState();
}

class _HelpDetailPageState extends State<HelpDetailPage> {
  int currentQueue = 0; //bisa sambungin dari DB
  int userQueueNumber = 0;
  String ticketNumber = '';
  Duration estimatedWaitTime = Duration.zero;
  DateTime? countdownEndTime;
  Timer? countdownTimer;

  bool hasTicket = false;

  @override
  void initState() {
    super.initState();
    _restoreState();
  }

  Future<void> _restoreState() async {
    final prefs = await SharedPreferences.getInstance();
    currentQueue = prefs.getInt('currentQueue') ?? 0;
    hasTicket = prefs.getBool('hasTicket') ?? false;

    if (hasTicket) {
      userQueueNumber = prefs.getInt('userQueue') ?? currentQueue + 1;
      ticketNumber = prefs.getString('ticketNumber') ?? '';
      final endMillis = prefs.getInt('countdownEndTime') ?? 0;
      countdownEndTime = DateTime.fromMillisecondsSinceEpoch(endMillis);
      _updateCountdown();
      _startCountdown();
    }

    setState(() {});
  }

  void _startCountdown() {
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateCountdown(),
    );
  }

  void _updateCountdown() {
    if (countdownEndTime == null) return;
    final now = DateTime.now();
    final remaining = countdownEndTime!.difference(now);

    setState(() {
      estimatedWaitTime = remaining.isNegative ? Duration.zero : remaining;
    });

    if (remaining.isNegative) {
      countdownTimer?.cancel();
    }
  }

  Future<void> _createTicket() async {
    final prefs = await SharedPreferences.getInstance();
    currentQueue += 1;
    userQueueNumber = currentQueue;
    ticketNumber = 'BNTN${Random().nextInt(90000) + 10000}';

    final waitTime = Duration(
      hours: Random().nextInt(23) + 1,
      minutes: Random().nextInt(60),
    );
    countdownEndTime = DateTime.now().add(waitTime);

    await prefs.setBool('hasTicket', true);
    await prefs.setInt('currentQueue', currentQueue);
    await prefs.setInt('userQueue', userQueueNumber);
    await prefs.setString('ticketNumber', ticketNumber);
    await prefs.setInt(
      'countdownEndTime',
      countdownEndTime!.millisecondsSinceEpoch,
    );

    hasTicket = true;
    _startCountdown();

    setState(() {});
  }

  Future<void> _cancelTicket() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('hasTicket');
    await prefs.remove('currentQueue');
    await prefs.remove('userQueue');
    await prefs.remove('ticketNumber');
    await prefs.remove('countdownEndTime');

    hasTicket = false;
    userQueueNumber = 0;
    ticketNumber = '';
    estimatedWaitTime = Duration.zero;
    countdownEndTime = null;
    countdownTimer?.cancel();

    setState(() {});
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}j : ${twoDigits(duration.inMinutes.remainder(60))}m : ${twoDigits(duration.inSeconds.remainder(60))}dtk";
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah Anda yakin ingin membuat tiket bantuan?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _createTicket();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tiket berhasil dibuat!')),
              );
            },
            child: const Text("Ya"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Bantuan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                'assets/icons/call.svg',
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Buat Bantuan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Ambil antrian Anda dan berbicara dengan CS kami.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoCard("Antrian saat ini", "$currentQueue"),
                _buildInfoCard(
                  "Waktu tunggu",
                  hasTicket ? _formatDuration(estimatedWaitTime) : "--",
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (hasTicket)
              SelectableText(
                "No. Bantuan: $ticketNumber",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 24),
            const Text("Hari Ini", style: TextStyle(color: Colors.blue)),
            const SizedBox(height: 12),
            if (hasTicket)
              _buildChatBubble("No. Antrian Anda:", userQueueNumber.toString())
            else
              _buildChatBubble("Anda belum mengambil antrian."),
            if (hasTicket)
              _buildChatBubble(
                "Mohon tunggu, kami akan segera menghubungi Anda kembali.",
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                hasTicket ? _cancelTicket() : _showConfirmationDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: hasTicket ? Colors.red : Colors.blue[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Text(
                hasTicket ? "Batalkan Antrian" : "Buat Tiket Bantuan",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, [String? bold]) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(fontSize: 14)),
          if (bold != null)
            Container(
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                bold,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              DateFormat.Hm().format(DateTime.now()),
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
