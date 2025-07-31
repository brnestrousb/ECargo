import 'dart:async';
import 'dart:math';
import 'package:ecargo_support/features/help/pages/help_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:ecargo_support/features/help/models/support_model.dart';

class HubPage extends StatefulWidget {
  //final SupportDetailContent? content;
  final HelpDetailPage? content;
  const HubPage({super.key, this.content});

  @override
  State<HubPage> createState() => _SupportDetailPageState();
}

class _SupportDetailPageState extends State<HubPage> {
  bool hasTicket = false;
  bool isLoading = false;
  int currentQueue = 0;
  String generatedTicketNumber = '';
  int userQueueNumber = 0;
  Timer? _timer;
  Duration waitTime = Duration.zero;
  DateTime? ticketCreatedAt;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentQueue = prefs.getInt('currentQueue') ?? 0;
      waitTime = Duration(seconds: prefs.getInt('waitTime') ?? 0);
      hasTicket = prefs.getBool('hasTicket') ?? false;
      generatedTicketNumber = prefs.getString('ticketNumber') ?? '';
      userQueueNumber = prefs.getInt('userQueueNumber') ?? 0;
      final createdAtStr = prefs.getString('ticketCreatedAt');
      if (createdAtStr != null) {
        ticketCreatedAt = DateTime.tryParse(createdAtStr);
      }
    });

    if (hasTicket && waitTime.inSeconds > 0) {
      _startTimer();
    }
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentQueue', currentQueue);
    await prefs.setInt('waitTime', waitTime.inSeconds);
    await prefs.setBool('hasTicket', hasTicket);
    await prefs.setString('ticketNumber', generatedTicketNumber);
    await prefs.setInt('userQueueNumber', userQueueNumber);
    if (ticketCreatedAt != null) {
      await prefs.setString(
        'ticketCreatedAt',
        ticketCreatedAt!.toIso8601String(),
      );
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (waitTime.inSeconds == 0) {
        timer.cancel();
        return;
      }
      setState(() {
        waitTime -= const Duration(seconds: 1);
      });
      _saveState();
    });
  }

  Future<void> _createTicket() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      hasTicket = true;
      generatedTicketNumber = _generateTicketNumber();
      userQueueNumber = currentQueue + 1;
      ticketCreatedAt = DateTime.now();
      currentQueue += 1;
      waitTime = const Duration(hours: 1);
      isLoading = false;
    });
    _startTimer();
    _saveState();
  }

  void _cancelTicket() {
    setState(() {
      hasTicket = false;
      generatedTicketNumber = '';
      userQueueNumber = currentQueue - 1;
      currentQueue -= 1;
      ticketCreatedAt = null;
      waitTime = Duration.zero;
    });
    _timer?.cancel();
    _saveState();
  }

  String _generateTicketNumber() {
    final random = Random();
    return 'BNTN${100000 + random.nextInt(900000)}';
  }

  Future<bool?> _showConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Buat tiket bantuan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF004B87),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _copyTicketNumber() {
    Clipboard.setData(ClipboardData(text: generatedTicketNumber));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('No. Bantuan disalin')));
  }

  Widget _buildQueueInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Antrian saat ini:'),
              const SizedBox(height: 4),
              Text('$currentQueue', style: const TextStyle(fontSize: 18)),
            ],
          ),
          Container(width: 1, height: 40, color: Color(0xFFCECECE)),
          Column(
            children: [
              const Text('Waktu tunggu (+-):'),
              Text(
                _formatDuration(waitTime),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${minutes}m : ${seconds}dtk';
  }

  Widget _buildTicketNumber() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No. Bantuan: '),
          GestureDetector(
            onTap: _copyTicketNumber,
            child: Row(
              children: [
                Text(
                  generatedTicketNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Icon(Icons.content_copy, size: 16, color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketMessages() {
    final time = ticketCreatedAt != null
        ? '${ticketCreatedAt!.hour.toString().padLeft(2, '0')}:${ticketCreatedAt!.minute.toString().padLeft(2, '0')}'
        : '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12, top: 16),
          child: Text('Hari ini', style: TextStyle(color: Colors.grey)),
        ),
        const SizedBox(height: 8),
        _buildMessageBubble('No. Antrian Anda:', '$userQueueNumber', time),
        _buildMessageBubble(
          '',
          'Mohon tunggu, kami akan segera menghubungi Anda kembali.',
          time,
        ),
      ],
    );
  }

  Widget _buildMessageBubble(String title, String content, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty) Text(title),
            Container(
              width: 260,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 2),
                ],
              ),
              child: Text(content),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    if (isLoading) {
      return const CircularProgressIndicator();
    }
    return SizedBox(
      width: 180,
      child: ElevatedButton(
        onPressed: _toggleTicket,
        style: ElevatedButton.styleFrom(
          backgroundColor: hasTicket ? Colors.red : const Color(0xFF004B87),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          hasTicket ? 'Batalkan' : 'Buat Tiket Bantuan',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void _toggleTicket() async {
    if (hasTicket) {
      _cancelTicket();
    } else {
      final shouldCreate = await _showConfirmationDialog();
      if (shouldCreate == true) {
        _createTicket();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bantuan')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              child: SvgPicture.asset(
                "assets/icons/call.svg",
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Buat Bantuan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Ambil antrian Anda dan berbicara dengan CS kami.'),
            const SizedBox(height: 16),
            _buildQueueInfo(),
            if (hasTicket) _buildTicketNumber(),
            const SizedBox(height: 24),
            _buildActionButton(),
            if (hasTicket) _buildTicketMessages(),
          ],
        ),
      ),
    );
  }
}
