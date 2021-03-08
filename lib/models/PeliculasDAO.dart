import 'package:movie_api/models/DirectorDAO.dart';
import 'package:movie_api/models/RepartoDAO.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_api/models/ClasificacionDAO.dart';
import 'package:movie_api/models/GeneroDAO.dart';

class PeliculasDAO extends ManagedObject<table_peliculas> implements table_peliculas{}

class table_peliculas{
    
    @primaryKey
    int id;
    
    int duracion;

    @Column(indexed: true)
    String sinopsis;

    @Column(unique: true)
    String titulo;
  
    DateTime fechaEstreno;

    @Relate(#peliculasDAOFK1) // Relacion foranea 1 a n
    ClasificacionDAO clasificacion;
    
    @Relate(#peliculasDAOFK2) // Relacion foranea 1 a n
    DirectorDAO director;

    @Relate(#peliculasDAOFK3) // Relacion foranea 1 a n
    GeneroDAO genero;

    ManagedSet<RepartoDAO> repartoDAOFK2;
}