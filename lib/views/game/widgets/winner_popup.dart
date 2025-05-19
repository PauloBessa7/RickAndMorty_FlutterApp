import 'package:flutter/material.dart';

Future showWinnerPopup(BuildContext context, String winnerName) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder:
        (_) => AlertDialog(
          title: const Text('🏁 Resultado'),
          content: Text(winnerName),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Sair'),
            ),
          ],
        ),
  );
}
