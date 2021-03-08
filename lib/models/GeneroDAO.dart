import 'package:movie_api/models/PeliculasDAO.dart';
import 'package:movie_api/movie_api.dart';

class GeneroDAO extends ManagedObject<table_genero> implements table_genero{}

class table_genero{
    
    @primaryKey
    int id;

    @Column(indexed: true)
    String nombre;

    @Column(indexed: true)
    String descripcion;

    ManagedSet<PeliculasDAO> peliculasDAOFK3;
}