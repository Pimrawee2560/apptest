import 'package:flutter/material.dart';
import 'package:flutter_database/models/TransactionItem.dart';
import 'package:flutter_database/providers/TransactionProvider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final nameengController = TextEditingController();
  final heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("เพิ่มข้อมูลต้นสน"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text("ชื่อสายพันธุ์")),
              autofocus: true,
              validator: (str) {
                if (str!.isEmpty) {
                  return "กรุณาใส่ชื่อสายพันธุ์";
                }
                return null;
              },
              controller: titleController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "ชื่ออังกฤษ"),
              autofocus: true,
              validator: (str) {
                if (str!.isEmpty) {
                  return "กรุณาใส่ถิ่ชื่ออังกฤษ";
                }
                return null;
              },
              controller:
                  nameengController, // ต้องสร้าง TextEditingController สำหรับชื่ออังกฤษด้วย
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text("ส่วนสูงของต้นสน")),
              keyboardType: TextInputType.number,
              validator: (value) {
                try {
                  if (value!.isNotEmpty) {
                    if (double.parse(value) >= 0) {
                      return null;
                    }
                  }
                  throw ();
                } catch (e) {
                  return "กรุณาใส่ส่วนสูงของต้นสน";
                }
              },
              controller: heightController,
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  //สร้าง ข้อมูล สำหรับ provider
                  TransactionItem transaction = TransactionItem(
                      title: titleController.text,
                      nameeng: nameengController.text,
                      height: double.parse(heightController.text),
                      date: DateTime.now().toIso8601String());
                  print(
                      "${transaction.title} ${transaction.nameeng} ${transaction.height} ${transaction.date}");

                  //ส่งข้อมูลให้ provider
                  var provider =
                      Provider.of<TransactionProvider>(context, listen: false);
                  provider.addTransaction(transaction);

                  Navigator.pop(context);
                }
              },
              child: Text(
                "เพิ่มข้อมูล",
                style: TextStyle(color: const Color.fromARGB(255, 245, 10, 10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
