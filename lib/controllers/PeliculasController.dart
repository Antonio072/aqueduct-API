import 'package:movie_api/models/PeliculasDAO.dart';
import 'package:movie_api/movie_api.dart';

class PeliculasController extends ResourceController{

  final ManagedContext context;
  PeliculasController(this.context);

  @Operation.get()
  Future<Response> getAllPeliculas() async{

    final peliculasQuery =Query<PeliculasDAO>(context);
    final peliculas = await peliculasQuery.fetch();
    return Response.ok(peliculas);
  }

  @Operation.get('id')
  Future<Response> getPeliculas(@Bind.path('id') int idPeliculas) async{
      final peliculaQuery = Query<PeliculasDAO>(context)..where( (a) => a.id).equalTo(idPeliculas);
      final pelicula = await peliculaQuery.fetchOne();
      return pelicula != null ? Response.ok(pelicula) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addPeliculas() async{
    
    final newPeliculas = PeliculasDAO()..read(await request.body.decode(), ignore:['id']);
    final newPeliculasQuery = Query<PeliculasDAO>(context)..values = newPeliculas;
    final pelicula = await newPeliculasQuery.insert();
    return Response.ok(pelicula);
  }

  @Operation.put('id')
  Future<Response> updatePeliculas(@Bind.path('id') int idPeliculas) async{
    
    final updatePeliculas = PeliculasDAO()..read(await request.body.decode());
    final updatePeliculasQuery = Query<PeliculasDAO>(context)..where( 
      (pelicula) => pelicula.id).equalTo(idPeliculas)..values = updatePeliculas;
    final pelicula = await updatePeliculasQuery.update();

    return Response.ok(pelicula);
  }

  @Operation.delete('id')
  Future<Response> deletePeliculas(@Bind.path('id') int idPeliculas) async{ 
    final deletePeliculasQuery = Query<PeliculasDAO>(context)..where((pelicula)=>pelicula.id).equalTo(idPeliculas);
    final pelicula = await deletePeliculasQuery.delete();

    return Response.ok(pelicula);
  }
  
}