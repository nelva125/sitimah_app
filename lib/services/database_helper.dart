import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/tin_transaction.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sitimah.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';
    const textNullable = 'TEXT';

    await db.execute('''
CREATE TABLE transactions (
  id $idType,
  date $textType,
  supplierName $textType,
  weightKg $realType,
  pricePerKg $realType,
  quality $textType,
  notes $textNullable
)
''');
  }

  Future<int> create(TinTransaction transaction) async {
    final db = await instance.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<TinTransaction> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'transactions',
      columns: ['id', 'date', 'supplierName', 'weightKg', 'pricePerKg', 'quality', 'notes'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TinTransaction.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TinTransaction>> readAllTransactions() async {
    final db = await instance.database;
    final orderBy = 'date DESC';
    final result = await db.query('transactions', orderBy: orderBy);

    return result.map((json) => TinTransaction.fromMap(json)).toList();
  }

  Future<int> update(TinTransaction transaction) async {
    final db = await instance.database;
    return db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
