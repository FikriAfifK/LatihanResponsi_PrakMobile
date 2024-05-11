import 'package:flutter/material.dart';
import 'package:latihan_responsi/load_data_source.dart';
import 'package:latihan_responsi/detail_meals_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMeals extends StatefulWidget {
  const DetailMeals({Key? key, required this.idMeals}) : super(key: key);
  final String idMeals;

  @override
  State<DetailMeals> createState() => _DetailMealsState();
}

class _DetailMealsState extends State<DetailMeals> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Detail"),
        centerTitle: true,
      ),
      body: _buildListDetailMealsBody(),
    );
  }

  Widget _buildListDetailMealsBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadDetailMeals(widget.idMeals),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            DetailMealsModel detailMealsModel =
                DetailMealsModel.fromJson(snapshot.data);
            return _buildSuccessSection(detailMealsModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(DetailMealsModel data) {
    return ListView.builder(
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index) {

        return _buildItemDetailMeals(data.meals![index]);
      },
    );
  }

  Widget _buildItemDetailMeals(Meals detailMealsData) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Image.network(detailMealsData.strMealThumb!),
          ),
          SizedBox(height: 10),
          Text(
            detailMealsData.strMeal!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),

          Container(
            width: double.infinity, // Atur lebar agar mengisi lebar maksimal
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center, // Mengatur posisi horizontal menjadi tengah
              children: [
                Text(
                  "Category: ${detailMealsData.strCategory ?? 'Unknown'}",
                ),
                SizedBox(width: 10),
                Text(
                  "Area: ${detailMealsData.strArea ?? 'Unknown'}",
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ingredients", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(detailMealsData.strIngredient1!),
                Text(detailMealsData.strIngredient2!),
                Text(detailMealsData.strIngredient3!),
                Text(detailMealsData.strIngredient4!),
                Text(detailMealsData.strIngredient5!),
                Text(detailMealsData.strIngredient6!),
                Text(detailMealsData.strIngredient7!),
                Text(detailMealsData.strIngredient8!),
                Text(detailMealsData.strIngredient9!),
                Text(detailMealsData.strIngredient10!),
                Text(detailMealsData.strIngredient11!),
                Text(detailMealsData.strIngredient12!),
                Text(detailMealsData.strIngredient13!),
                Text(detailMealsData.strIngredient14!),
                Text(detailMealsData.strIngredient15!),
                Text(detailMealsData.strIngredient16!),
                Text(detailMealsData.strIngredient17!),
                Text(detailMealsData.strIngredient18!),
                Text(detailMealsData.strIngredient19!),
                Text(detailMealsData.strIngredient20!),

                Text("Instructions", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(detailMealsData.strInstructions!),
                SizedBox(height: 20),
              ],
            ),
          ),

          ElevatedButton.icon(
            onPressed: () {
              launchURL(detailMealsData.strYoutube!);
            },
            icon: Icon(Icons.play_arrow_sharp),
            label: Text("Watch Tutorial"),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                minimumSize: Size(MediaQuery.of(context).size.width, 50)
            ),
          ),
        ],
      ),
    );
  }

}

Future <void> launchURL(String url) async {
  final Uri _url = Uri.parse(url);
  if(!await launchUrl(_url)){
    throw "Couldn't launch $_url";
  }
}

// ListView.builder(
//   shrinkWrap: true,
//   itemCount: 1, // Karena kita hanya memiliki satu objek Meals di sini
//   itemBuilder: (context, index) {
//     final meal = detailMealsData; // Mendapatkan objek Meals
//
//     // Mengumpulkan daftar bahan dari objek Meals
//     final ingredients = <String>[];
//     for (int i = 1; i <= 20; i++) {
//       final ingredient = meal['strIngredient$i'];
//       if (ingredient != null && ingredient.isNotEmpty) {
//         ingredients.add(ingredient);
//       }
//     }
//
//     return ListTile(
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold)),
//           // Menampilkan daftar bahan
//           for (var ingredient in ingredients)
//             Text("- $ingredient"),
//         ],
//       ),
//     );
//   },
// ),