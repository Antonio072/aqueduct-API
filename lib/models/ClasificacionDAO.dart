import 'package:movie_api/models/PeliculasDAO.dart';
import 'package:movie_api/movie_api.dart';

class ClasificacionDAO extends ManagedObject<table_clasificacion> implements table_clasificacion{}

class table_clasificacion{
    
    @primaryKey
    int clave;

    @Column(indexed: true)
    String nombre;

    @Column(indexed: true)
    String descripcion;

    ManagedSet<PeliculasDAO> peliculasDAOFK1;
}