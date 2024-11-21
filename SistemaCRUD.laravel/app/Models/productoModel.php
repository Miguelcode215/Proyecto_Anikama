<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class productoModel extends Model
{
    use HasFactory;

    protected $connection = "mysql";
    protected $table = "productos";
    protected $primaryKey = "idProducto";
    public $timestamps = false;

    protected $fillable = ['NombrePro', 'Descripcion', 'Precio', 'Stock', 'FechaRegistro', 
                            'FechaVencimiento', 'Estado', 'idCategoria'];
}
