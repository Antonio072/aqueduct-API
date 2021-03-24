import 'package:movie_api/models/GeneroDAO.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_api/helpers/properties.dart';
class GeneroController extends ResourceController{

  final ManagedContext context;
  GeneroController(this.context);

  @Operation.get()
  Future<Response> getAllGenero(@Bind.header("Authorization") String authHeader) async{

    if( !Properties.isAuthorized(authHeader)){
      return Response.forbidden();
    }

    final generosQuery =Query<GeneroDAO>(context);
    final generos = await generosQuery.fetch();
    return Response.ok(generos);
  }

  @Operation.get('id')
  Future<Response> getGenero(@Bind.path('id') int idGenero) async{
      final generoQuery = Query<GeneroDAO>(context)..where( (a) => a.id).equalTo(idGenero);
      final genero = await generoQuery.fetchOne();
      return genero != null ? Response.ok(genero) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addGenero() async{
    
    final newGenero = GeneroDAO()..read(await request.body.decode(), ignore:['id']);
    final newGeneroQuery = Query<GeneroDAO>(context)..values = newGenero;
    final genero = await newGeneroQuery.insert();
    return Response.ok(genero);
  }

  @Operation.put('id')
  Future<Response> updateGenero(@Bind.path('id') int idGenero) async{
    
    final updateGenero = GeneroDAO()..read(await request.body.decode());
    final updateGeneroQuery = Query<GeneroDAO>(context)..where( 
      (genero) => genero.id).equalTo(idGenero)..values = updateGenero;
    final genero = await updateGeneroQuery.update();

    return Response.ok(genero);
  }

  @Operation.delete('id')
  Future<Response> deleteGenero(@Bind.path('id') int idGenero) async{ 
    final deleteGeneroQuery = Query<GeneroDAO>(context)..where((genero)=>genero.id).equalTo(idGenero);
    final genero = await deleteGeneroQuery.delete();

    return Response.ok(genero);
  }
  
}