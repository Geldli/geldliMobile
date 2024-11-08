// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, sort_child_properties_last

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/components/assets_components/asset_view_assets.dart';
import 'package:flutter_application_2/components/assets_components/form_update.dart';
import 'package:flutter_application_2/components/assets_components/list_tags.dart';
import 'package:flutter_application_2/components/expensives_components/expensive_view.dart';
import 'package:flutter_application_2/components/expensives_components/form_new_add.dart';
import 'package:flutter_application_2/components/expensives_components/form_update.dart';
import 'package:flutter_application_2/components/expensives_components/list_tags.dart';
import 'package:flutter_application_2/controller/asset_controller.dart';
import 'package:flutter_application_2/controller/tag_asset_controller.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/model/Asset.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';

class PanelListA extends StatefulWidget {
  const PanelListA({super.key});
  @override
  State<PanelListA> createState() => _PanelListAState();
}

class _PanelListAState extends State<PanelListA> {
  double totalValue = 0;

  AssetController _assetController = AssetController();
  TagAssetController _tagAssetController = TagAssetController();
  int idAsset = 30;
  TextEditingController query = TextEditingController();
  List<Asset> response = [];
  var controller = 0;
  final int userId = 3;
 @override
  
  initState() {
    super.initState();
    loadAssets();
    
  }

Future<void> loadAssets() async {
  try {
    await _assetController.getAssetByUserId(userId);
    print("Despesaitas:");
        _assetController.assetList.forEach((element) {
          print(element.titleD);
        });
      setState(() {
      response = _assetController.assetList;
      totalValue = _assetController.totalAsset();
    });
  } catch (e) {
    print('Erro ao carregar despesas: $e');
  }
}


void handleCategorySelected(Tag? selectedTag) async {
  if (selectedTag == null) return;

  List<Asset> filteredAssets = await _assetController.getByCategory(userId, selectedTag.titleC);

  setState(() {
    this.selectedCategory = selectedTag; 
    response = filteredAssets; 
    totalValue = filteredAssets.fold(0, (sum, asset) => sum + asset.valueD);  });
}


void getAssetsByQuery() {
  String searchQuery = query.text.trim(); 

  if (searchQuery.isEmpty) {
   
    setState(() {
      response = List.from(_assetController.assetList);
      totalValue = _assetController.totalAsset();
    });
    return;
  }

  // 
  List<Asset> filteredAssets = _assetController.assetList.where((expensive) {
    return expensive.titleD.toUpperCase().contains(searchQuery.toUpperCase());
  }).toList();

  setState(() {
    response = filteredAssets; 
    totalValue = filteredAssets.fold(0, (sum, asset) => sum + asset.valueD); // Atualiza o total
  });
}

  
  Tag? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              ListTagA(onCategorySelected: handleCategorySelected),
              SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 0, 5),
                 padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20), 
                  decoration: BoxDecoration(
                    border: Border.all(color: myWhite,width: 2),borderRadius: BorderRadius.circular(10) ),
                  child: Text("R\$ " + totalValue.toStringAsFixed(2), style: TextStyle(color: myWhite, fontSize: 16, fontWeight: FontWeight.bold),)),
              ),
              // barra de pesquisa
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: query,
                      decoration: InputDecoration(
                        hintText: "Pesquisar despesas",
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        filled: true,
                        fillColor: myWhite,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: getAssetsByQuery,
                    icon: Icon(Icons.search,color: myWhite, size: 25)
                    ),
                  IconButton(
                    icon: Icon(Icons.clear,color: myWhite, size: 25),
                    onPressed: (){
                      
                      query.text = "";
                      response = _assetController.assetList;
                      totalValue = _assetController.totalAsset();
                      setState(() {
                        
                      });
                    },
                  )
                ],
              ),
    
              SizedBox(height: 15),
    
              Expanded(
                child: ListView.builder(
                  itemCount: response.isNotEmpty ? response.length : _assetController.assetList.length,
                  itemBuilder: (context, index) {
                  Asset thisAsset = response.isNotEmpty ? response[index] : _assetController.assetList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: myBlack, 
                        borderRadius: BorderRadius.circular(20)
                      ),
                      padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),   
                      child: ListTile(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AssetView(thisAsset: thisAsset)
                          ),
                        trailing: Container(
                          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                          decoration: BoxDecoration(
                            color: thisAsset.category!.toColor(),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(thisAsset.category!.titleC, style: categoryText),
                        ),
                        leading: PopupMenuButton(
                          iconColor: myWhite,
                          color: myWhite,
                          onSelected: (value) async {
                            if(value == "delete"){
                             _assetController.delete(3, thisAsset.titleD);
                            setState(() {
                              response.remove(thisAsset);
                              totalValue = _assetController.totalAsset();                            
                              });
                            }  
                            if(value == "edit"){
                             //_assetController.edit(thisAsset, idAsset);
                             setState(() {
                               
                             });
                            }  

                          },
                          itemBuilder: (BuildContext context){
                            return [
                              PopupMenuItem(
                                child: FormNewUpA(asset: thisAsset, id_asset: thisAsset.titleD),
                                value: 'edit',
                                height: 35,
                              ),
                              PopupMenuItem(
                                child: Text("Excluir"),
                                value: 'delete',
                                height: 35,
                              )
                            ];
                          }
                          ),
                        title: Text(thisAsset.titleD),
                        titleTextStyle: listViewTitle,
                      ),                                    
                    );                    
                  },
                  )
              )
            ],
          ),
        ),
      )
    
    );
  }
}