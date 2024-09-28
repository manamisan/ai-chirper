import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final wordbookProvider = StateProvider((ref) => 'wordbook');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordbook = ref.watch(wordbookProvider);
    final List<Map<String, String>> wordList = [
      {
        'word': 'Apple',
        'translation': 'りんご',
        'example': 'I eat an apple every day.',
      },
      {
        'word': 'test2',
        'translation': 'テスト2',
        'example': 'This is a test example.',
      },
      {
        'word': 'test3',
        'translation': 'テスト3',
        'example': 'This is another test example.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('listlist'),
      ),
      body: ListView.builder(
        itemCount: wordList.length,
        itemBuilder: (context, index) {
          final word = wordList[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    word['word']!,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    word['translation']!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    word['example']!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
