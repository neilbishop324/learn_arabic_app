// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_word_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TextWordDao? _textWordDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TextWord` (`id` TEXT NOT NULL, `ar` TEXT NOT NULL, `en` TEXT NOT NULL, `tr` TEXT NOT NULL, `index` INTEGER NOT NULL, `level` TEXT NOT NULL, `pos` TEXT NOT NULL, `createdAt` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TextWordDao get textWordDao {
    return _textWordDaoInstance ??= _$TextWordDao(database, changeListener);
  }
}

class _$TextWordDao extends TextWordDao {
  _$TextWordDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _textWordInsertionAdapter = InsertionAdapter(
            database,
            'TextWord',
            (TextWord item) => <String, Object?>{
                  'id': item.id,
                  'ar': item.ar,
                  'en': item.en,
                  'tr': item.tr,
                  'index': item.index,
                  'level': item.level,
                  'pos': item.pos,
                  'createdAt': item.createdAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TextWord> _textWordInsertionAdapter;

  @override
  Future<List<TextWord>> findAllTextWords() async {
    return _queryAdapter.queryList('SELECT * FROM TextWord',
        mapper: (Map<String, Object?> row) => TextWord(
            id: row['id'] as String,
            ar: row['ar'] as String,
            en: row['en'] as String,
            tr: row['tr'] as String,
            index: row['index'] as int,
            level: row['level'] as String,
            pos: row['pos'] as String,
            createdAt: row['createdAt'] as String));
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM TextWord WHERE id=?1', arguments: [id]);
  }

  @override
  Future<void> insertTextWord(TextWord textWord) async {
    await _textWordInsertionAdapter.insert(textWord, OnConflictStrategy.abort);
  }
}
