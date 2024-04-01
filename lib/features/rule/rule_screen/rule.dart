import 'package:flutter/material.dart';
import 'package:hostel_nepal/constants/rule_list.dart';
import 'package:hostel_nepal/features/dashboard/dashboard_main.dart';

class RuleForm extends StatefulWidget {
  const RuleForm({super.key});

  @override
  State<RuleForm> createState() => _RuleFormState();
}

class _RuleFormState extends State<RuleForm> {
  final List<String> _rules = [];

  @override
  void initState() {
    super.initState();
    _rules.addAll(rule);
  }

  void _showAddRuleDialog() {
    TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Rule'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Enter your rule'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  String newRule = textController.text;
                  if (newRule.isNotEmpty) {
                    _rules.insert(0, newRule);
                  }
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddRuleDialog,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _rules.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_rules[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _rules.removeAt(index); // Remove the rule from the list
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardMain(hid: '',)));
              },
              child: const Text('Next'),
            ),
          )
        ],
      ),
    );
  }
}
