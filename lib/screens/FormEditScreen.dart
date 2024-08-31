import 'package:flutter/material.dart';
import 'package:flutter_database/models/TransactionItem.dart';
import 'package:flutter_database/providers/TransactionProvider.dart';
import 'package:provider/provider.dart';

class FormEditScreen extends StatefulWidget {
  final TransactionItem data;
  const FormEditScreen({super.key, required this.data});

  @override
  State<FormEditScreen> createState() => _FormEditScreenState();
}

class _FormEditScreenState extends State<FormEditScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final nameengController = TextEditingController();
  final heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.data.title.toString();
    nameengController.text = widget.data.nameeng.toString();
    heightController.text = widget.data.height.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("แก้ไขข้อมูลต้นสน"),
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
                  return "กรุณาใส่ชื่ออังกฤษของต้นสน";
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
                      id: widget.data.id,
                      title: titleController.text,
                      nameeng: nameengController.text,
                      height: double.parse(heightController.text),
                      date: DateTime.now().toIso8601String());
                  print(
                      "${transaction.title} ${transaction.nameeng} ${transaction.height} ${transaction.date}");

                  //ส่งข้อมูลให้ provider
                  var provider =
                      Provider.of<TransactionProvider>(context, listen: false);
                  provider.updateTransaction(transaction);

                  Navigator.pop(context);
                }
              },
              child: Text(
                "แก้ไขข้อมูล",
                style: TextStyle(color: const Color.fromARGB(255, 245, 10, 10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
