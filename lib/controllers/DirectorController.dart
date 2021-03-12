import 'package:movie_api/models/DirectorDAO.dart';
import 'package:movie_api/movie_api.dart';

class DirectorController extends ResourceController{

  final ManagedContext context;
  DirectorController(this.context);

  @Operation.get()
  Future<Response> getAllDirector() async{

    final directorsQuery =Query<DirectorDAO>(context);
    final directors = await directorsQuery.fetch();
    return Response.ok(directors);
  }

  @Operation.get('id')
  Future<Response> getDirector(@Bind.path('id') int idDirector) async{
      final directorQuery = Query<DirectorDAO>(context)..where( (a) => a.id).equalTo(idDirector);
      final director = await directorQuery.fetchOne();
      return director != null ? Response.ok(director) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addDirector() async{
    
    final newDirector = DirectorDAO()..read(await request.body.decode(), ignore:['id']);
    final newDirectorQuery = Query<DirectorDAO>(context)..values = newDirector;
    final director = await newDirectorQuery.insert();
    return Response.ok(director);
  }

  @Operation.put('id')
  Future<Response> updateDirector(@Bind.path('id') int idDirector) async{
    
    final updateDirector = DirectorDAO()..read(await request.body.decode());
    final updateDirectorQuery = Query<DirectorDAO>(context)..where( 
      (director) => director.id).equalTo(idDirector)..values = updateDirector;
    final director = await updateDirectorQuery.update();

    return Response.ok(director);
  }

  @Operation.delete('id')
  Future<Response> deleteDirector(@Bind.path('id') int idDirector) async{ 
    final deleteDirectorQuery = Query<DirectorDAO>(context)..where((director)=>director.id).equalTo(idDirector);
    final director = await deleteDirectorQuery.delete();

    return Response.ok(director);
  }
  
}