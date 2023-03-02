import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firstapp/addCat.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late dynamic categories;
  bool initialized = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      categories = await getCats();
      initialized = true;

    });

  }
  CollectionReference instance = FirebaseFirestore.instance.collection('categories');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(80),child:
      Container(margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.symmetric(horizontal: 20),
          color:Colors.orange[200],

          child:Row(
        children: [
          Expanded(
            child:
            Container(
              padding: EdgeInsets.only(top: 30),
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor:Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  hintText: "search",
                  prefixIcon:Icon(Icons.search),
                  prefixIconColor:Colors.white,
                ),
              ),
            ),
          ),

           /* Container(
              padding: EdgeInsets.only(top: 30),
              child: IconButton(icon:Icon(Icons.add),onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (BuildContext builder){return AddCat();}));
          },),
            )*/
        ],
      )),),
      body: FutureBuilder<QuerySnapshot>(
        future: instance.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          print(snapshot.data!.docs);

              return Container(
                color:  Colors.orange[200],
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Chose a category",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        children: [
                          ...?initialized
                              ? snapshot.data!.docs.map((e) => Container(
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color(0x99000000),
                                              spreadRadius: 3,
                                              blurRadius: 8,
                                              offset: Offset(4, 4))
                                        ],
                                        borderRadius: BorderRadius.circular(18),
                                        color: Colors.white),
                                    margin: EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Image.network(e["image"]!,height:140 ,width: 100,),
                                        Text(e["name"],
                                          style: TextStyle(fontWeight: FontWeight.bold)),

                                      ],
                                    ),
                                  ))
                              : null
                        ],
                      ),
                    ),
                  ],
                ),
              );

          }
      ),
    );
  }

  Future<QuerySnapshot> getCats() {
    // Call the user's CollectionReference to add a new user
    return instance.get();

  }

}
