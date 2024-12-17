part of 'pages.dart';

class TambahResepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Resep'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk membuat makanan untuk akhir bulan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MakananAkhirBulanPage()),
                );
              },
              child: Text('Buat Makanan untuk Akhir Bulan'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk membuat makanan sesuai resep populer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResepPopulerPage()),
                );
              },
              child: Text('Buat Makanan Sesuai Resep Populer'),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman untuk Makanan Akhir Bulan
class MakananAkhirBulanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Makanan untuk Akhir Bulan'),
      ),
      body: Center(
        child: Text('Halaman untuk Makanan Akhir Bulan'),
      ),
    );
  }
}

// Halaman untuk Resep Populer
class ResepPopulerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Populer'),
      ),
      body: Center(
        child: Text('Halaman untuk Resep Populer'),
      ),
    );
  }
}
