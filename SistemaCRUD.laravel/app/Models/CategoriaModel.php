<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CategoriaModel extends Model
{
    use HasFactory;

    protected $connection = "mysql";
    protected $table = "categoria";
    protected $primaryKey = "idCategoria";
    public $timestamps = false;

    protected $fillable = ['NombreCat'];
}
