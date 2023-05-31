import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

class Todos extends StatefulWidget {
  const Todos({Key? key, required this.onSaveTodo}) : super(key: key);

  final Function onSaveTodo;

  @override
  _TodosState createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  String dropdownvalue = 'Work';
  final List<String> items = ['Routine', 'Work', 'Others'];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(5.0)),
                const Icon(Icons.list_alt_outlined),
                const Text('Kegiatan'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Judul Kegiatan',
                        )),
                  ),
                )
              ],
            ),
            Row(
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                Icon(Icons.notes),
                Text('Keterangan'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 20, 20),
              child: TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tambah Keterangan'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const <Widget>[
                    Icon(Icons.date_range),
                    Text('Tanggal Mulai'),
                  ],
                ),
                Row(
                  children: const <Widget>[
                    Icon(Icons.date_range_outlined),
                    Text('Tanggal Selesai'),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(20.0)),
                Expanded(
                  child: DateTimePicker(
                        initialValue: '',
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Date',
                        onChanged: (val) => print(val),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      )
                ),
                SizedBox(width: 50,),
                Expanded(
                  child: DateTimePicker(
                        initialValue: '',
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Date',
                        onChanged: (val) => print(val),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: const <Widget>[
                    Icon(Icons.category),
                    Text('Kategori'),
                  ],
                ),
                Row(
                  children: [
                    DropdownButton(
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        }),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Batal'),
                        ))),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          widget.onSaveTodo(
                              _titleController.text,
                              _descriptionController.text,
                              _startDateController.text,
                              _endDateController.text,
                              dropdownvalue);
                          Navigator.pop(context, 'Data saved successfully.');
                            showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 180,
                              width: 250,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 50, 5, 5),
                                child: Column(
                                  children: [
                                    Text("Berhasil",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                    SizedBox(height: 10),
                                    Text("Kegiatan berhasil ditambahkan",
                                        style: TextStyle(fontSize: 14),
                                        textAlign: TextAlign.center),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 35)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                top: -30,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 26,
                                    child: Icon(Icons.check,
                                        size: 30, color: Colors.white),
                                  ),
                                )),
                          ],
                        ),
                      );
                    });
                        },
                        child: const Text('Simpan'),
                      )),
                )
              ],
            )
          ],
        ));
  }
}
