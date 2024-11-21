<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetalleModel extends Model
{
    use HasFactory;

    protected $connection = "mysql";
    protected $table = "detalleventa";
    protected $primaryKey = "idDetalle";
    public $timestamps = false;

    protected $fillable = ['idVenta', 'idProducto', 'Unidades', 'Total'];
}
