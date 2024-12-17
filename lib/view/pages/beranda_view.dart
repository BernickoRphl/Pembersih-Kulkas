part of 'pages.dart';


class Beranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Makanan Hari Ini'),
      ),
      body: RecipeGrid(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Buat Resep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Tambahkan logika navigasi sesuai kebutuhan
        },
      ),
    );
  }
}

class RecipeGrid extends StatelessWidget {
  final List<String> recipes = [
    'Resep Nasi Goreng',
    'Resep Mie Goreng',
    'Resep Ayam Penyet',
    'Resep Sate Ayam',
    'Resep Rendang',
    'Resep Soto Ayam',
    'Resep Gado-Gado',
    'Resep Bakso',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://via.placeholder.com/150', // Ganti dengan URL gambar resep
                  fit: BoxFit.cover,
                  height: 100,
                  width: double.infinity,
                ),
                SizedBox(height: 8),
                Text(
                  recipes[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}