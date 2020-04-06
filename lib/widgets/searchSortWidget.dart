import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncov19infor/blocs/blocs.dart';
import 'package:ncov19infor/widgets/sortWidget.dart';
import 'package:search_widget/search_widget.dart';
import 'package:ncov19infor/models/models.dart';
import 'package:google_fonts/google_fonts.dart';


class SearchSortWidget extends StatefulWidget {
  @override
  _SearchSortWidgetState createState() => _SearchSortWidgetState();
}

class _SearchSortWidgetState extends State<SearchSortWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CountryStatBloc, CountryStatState>(
      listener: (context, state){

      },
      builder: (context, state){
        if ( state is CountryStatLoaded ){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: SearchWidget<Country>(
                    hideSearchBoxWhenItemSelected: false,
                    listContainerHeight: MediaQuery.of(context).size.height / 4,
                    noItemsFoundWidget: NoItemsFound(),
                    selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                      return SelectedItemWidget(selectedItem, deleteSelectedItem);
                    },
                    textFieldBuilder: (controller, focusNode) {
                      return MyTextField(controller, focusNode);
                    },
                    dataList: state.allCountry,
                    popupListItemBuilder: (Country item) {
                      return PopupListItemWidget(item);
                    },
                    queryBuilder: (String query, List<Country> list) {
                      return list.where((Country item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
                    },
                    onItemSelected: (item){
                      BlocProvider.of<CountryStatBloc>(context).add(SearchCountryStat(searchCountry: item));
                    },
                ),

              ),
              SafeArea(
                child: SingleChildScrollView(
                  scrollDirection : Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 10,),
                      SortWidget(
                        title: 'A-Z',
                        icon: Icon(Icons.arrow_upward),
                        isChoosed: true,
                        width: 80,
                      ),
                      SizedBox(width: 15,),
                      SortWidget(
                        title: 'Cases',
                        icon: Icon(Icons.arrow_upward),
                        isChoosed: false,
                        width: 95,
                      ),
                      SizedBox(width: 15,),
                      SortWidget(
                        title: 'Deaths',
                        icon: Icon(Icons.arrow_upward),
                        isChoosed: false,
                        width: 100,
                      ),
                      SizedBox(width: 15,),
                      SortWidget(
                        title: 'Recovered',
                        icon: Icon(Icons.arrow_upward),
                        isChoosed: false,
                        width: 125,
                      ),
                      SizedBox(width: 15,),
                      SortWidget(
                        title: 'Active cases',
                        icon: Icon(Icons.arrow_upward),
                        isChoosed: false,
                      ),
                      SizedBox(width: 15,)

                    ],
                  ),

                ),
              )

            ],
          );
        }
        if ( state is CountryStatSearchLoaded){
          final searchCountry = state.searchCountry;
          final List<Country> listSarch =[searchCountry];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: ItemWidget(searchCountry),

              ),
              SafeArea(
                child: SingleChildScrollView(
                  scrollDirection : Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 10,),
                      SortWidget(
                        title: 'A-Z',
                        icon: Icon(Icons.arrow_upward),
                        isChoosed: true,
                        width: 80,
                      ),
                      SizedBox(width: 15,),
                      SortWidget(
                        title: 'Cases',
                        icon: Icon(Icons.arrow_upward),
                        isChoosed: false,
                        width: 95,
                      ),
                      SizedBox(width: 15,),
                      SortWidget(
                        title: 'Deaths',
                        icon: Icon(Icons.arrow_upward),
                        isChoosed: false,
                        width: 100,
                      ),
                      SizedBox(width: 15,),
                      SortWidget(
                        title: 'Recovered',
                        icon: Icon(Icons.arrow_upward),
                        isChoosed: false,
                        width: 125,
                      ),
                      SizedBox(width: 15,),
                      SortWidget(
                        title: 'Active cases',
                        icon: Icon(Icons.arrow_upward),
                        isChoosed: false,
                      ),
                      SizedBox(width: 15,)

                    ],
                  ),

                ),
              )

            ],
          );

        }
        return Container();
      },
    );
  }
}


class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final Country item;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(12),
      child: Text(
        item.title,
        style: GoogleFonts.cabin(
          textStyle: TextStyle(
              fontSize: 16

          )
        )
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search country here...",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);

  final Country selectedItem;
  final VoidCallback deleteSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                selectedItem.title,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, size: 22),
            color: Colors.grey[700],
            onPressed: deleteSelectedItem,
          ),
        ],
      ),
    );
  }
}


class ItemWidget extends StatelessWidget {
  const ItemWidget(this.selectedItem);

  final Country selectedItem;
//  final VoidCallback deleteSelectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryStatBloc, CountryStatState>(
      builder: (context, state){
        return Container(
//      color: Colors.greenAccent,
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius:  BorderRadius.circular(10),

          ),
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 4,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Text(
                    selectedItem.title,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, size: 22),
                color: Colors.grey[700],
                onPressed: (){
                  BlocProvider.of<CountryStatBloc>(context).add(FetchCountryStat());

                },
              ),
            ],
          ),
        );
      },
    );
  }
}