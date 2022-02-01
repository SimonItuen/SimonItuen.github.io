import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/pages/diseases/DiseaseUpdatePage.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum CountType { year, month, life, date, nil }

class ExpiryCountTile extends StatefulWidget {
  final int index;
  final formKey;
  final VoidCallback onDeletePress;

  ExpiryCountTile({
    Key? key,
    required this.index,
    required this.formKey,
    required this.onDeletePress,
  }) : super(key: key);

  @override
  State<ExpiryCountTile> createState() => _ExpiryCountTileState();
}

class _ExpiryCountTileState extends State<ExpiryCountTile> {
  bool isError = false;
  TextEditingController textController = TextEditingController();

  bool isLoading = false;

  bool isButtonPressed = false;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = Provider.of<AppProvider>(context, listen: false)
        .selectedDisease
        .countRule[widget.index]
        .replaceAll('y', '')
        .replaceAll('m', '')
        .replaceAll('life', '');
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
    CountType diseaseCountType = CountType.year;
    String rule = Provider.of<AppProvider>(context, listen: true)
        .selectedDisease
        .countRule[widget.index];
    if (rule.toLowerCase().endsWith('y')) {
      diseaseCountType = CountType.year;
    } else if (rule.toLowerCase().endsWith('m')) {
      diseaseCountType = CountType.month;
    } else if (rule.toLowerCase().contains('/')) {
      diseaseCountType = CountType.date;
    } else if (rule.toLowerCase() == 'life') {
      diseaseCountType = CountType.life;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Text(
                '${widget.index + 1}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8)),
          ),
          Visibility(
            visible: diseaseCountType != CountType.life,
            child: Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  onTap: () async {
                    if (diseaseCountType == CountType.date) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await _selectDate(context);
                    }
                  },
                  onChanged: (val) {
                    isButtonPressed = false;
                    if (isError) {
                      widget.formKey.currentState!.validate();
                    }
                    if (diseaseCountType == CountType.year) {
                      Provider.of<AppProvider>(context, listen: false)
                          .selectedDisease
                          .countRule[widget.index] = '${val}y';
                    } else if (diseaseCountType == CountType.month) {
                      Provider.of<AppProvider>(context, listen: false)
                          .selectedDisease
                          .countRule[widget.index] = '${val}m';
                    }
                  },
                  validator: (val) {
                    if (!isButtonPressed) {
                      return null;
                    }
                    isError = true;
                    if (val!.isEmpty) {
                      return '${locale!.cannotBeEmpty}';
                    } else {
                      isError = false;
                      return null;
                    }
                  },
                  controller: textController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: '',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 1),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 2)),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: DropdownButtonFormField(
              value: diseaseCountType,
              onChanged: (value) async {
                textController.text = ' ';
                if (value == CountType.year) {
                  Provider.of<AppProvider>(context, listen: false)
                      .selectedDisease
                      .countRule[widget.index] = 'y';
                } else if (value == CountType.month) {
                  Provider.of<AppProvider>(context, listen: false)
                      .selectedDisease
                      .countRule[widget.index] = 'm';
                } else if (value == CountType.nil) {
                  Provider.of<AppProvider>(context, listen: false)
                      .selectedDisease
                      .countRule[widget.index] = ' ';
                } else if (value == CountType.date) {
                  await _selectDate(context);
                } else {
                  Provider.of<AppProvider>(context, listen: false)
                      .selectedDisease
                      .countRule[widget.index] = 'life';
                }
                setState(() {});
              },
              items: [
                DropdownMenuItem(
                  value: CountType.year,
                  child: Text('${locale!.years}'),
                ),
                DropdownMenuItem(
                  value: CountType.month,
                  child: Text('${locale.months}'),
                ),
                DropdownMenuItem(
                  value: CountType.date,
                  child: Text('${locale.fixedDate}'),
                ),
                DropdownMenuItem(
                  value: CountType.life,
                  child: Text('${locale.life}'),
                ),
              ],
              decoration: InputDecoration(
                isDense: true,
                hintText: '',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 2)),
              ),
            ),
          ),
          InkWell(
            onTap: widget.onDeletePress,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
                child: Icon(
                  Icons.delete_rounded,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).errorColor.withOpacity(0.8),
                  border: Border.all(
                      color: Theme.of(context).errorColor.withOpacity(0.8)),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year, 1, 1),
      lastDate: DateTime(DateTime.now().year, 12, 31),
    );
    if (selected != null && selected != selectedDate) {
      selectedDate = selected;
      Provider.of<AppProvider>(context, listen: false)
              .selectedDisease
              .countRule[widget.index] =
          '${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day}';
      textController.text =
          '${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day}';
      setState(() {});
    }
  }
}
