<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VentaModel extends Model
{
    use HasFactory;

    protected $connection = "mysql";
    protected $table = "venta";
    protected $primaryKey = "idVenta";
    public $timestamps = false;

    protected $fillable = ['FechaEmicion', 'Total', 'Estado'];
}
