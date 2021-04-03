abstract class Database<T> {

  Future<void> create(T element);
  Future<T> get(int id);
  Future<List<T>> getAll();
  Future<void> update(T element);
  Future<void> delete(int id);

}