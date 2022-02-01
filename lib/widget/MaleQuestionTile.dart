import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/pages/diseases/DiseaseUpdatePage.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaleQuestionTile extends StatefulWidget {
  final int index;
  final formKey;
  final VoidCallback onDeletePress;

  MaleQuestionTile({
    Key? key,
    required this.index,
    required this.formKey,
    required this.onDeletePress,
  }) : super(key: key);

  @override
  State<MaleQuestionTile> createState() => _MaleQuestionTileState();
}

class _MaleQuestionTileState extends State<MaleQuestionTile> {
  bool isError = false;
  TextEditingController enController = TextEditingController();
  TextEditingController boController = TextEditingController();

  bool isLoading = false;

  bool isButtonPressed = false;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enController.text = Provider.of<AppProvider>(context, listen: false)
        .selectedVaccine
        .vaccineQuestionsMaleEn[widget.index];
    boController.text = Provider.of<AppProvider>(context, listen: false)
        .selectedVaccine
        .vaccineQuestionsMaleBo[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: TextFormField(
                    
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    onChanged: (val) {
                      isButtonPressed = false;
                      if (isError) {
                        widget.formKey.currentState!.validate();
                      }
                      Provider.of<AppProvider>(context, listen: false)
                          .selectedVaccine
                          .vaccineQuestionsMaleBo[widget.index] = val;
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
                    controller: boController,
                    decoration: InputDecoration(
                      hintText: 'Bokmål',
                      labelText: 'Bokmål',
                      isDense: true,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: TextFormField(
                    
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    onChanged: (val) {
                      isButtonPressed = false;
                      if (isError) {
                        widget.formKey.currentState!.validate();
                      }
                      Provider.of<AppProvider>(context, listen: false)
                          .selectedVaccine
                          .vaccineQuestionsMaleEn[widget.index] = val;
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
                    controller: enController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'English',
                      labelText: 'English',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
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
              ],
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
}
