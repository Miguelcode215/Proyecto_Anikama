<div class="modal fade" id="ModalNewPro" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Nuevo Producto</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="{{url('NuevoPro')}}" method="post">
            @csrf
            <label>Nombre del Producto: 
                <input type="text" name="NombrePro">
            </label>
            <label>Descripcion: 
                <input type="text" name="Descripcion">
            </label>
            <label>Precio: 
                <input type="decimal" name="Precio">
            </label>
            <label>Stock: 
                <input type="number" name="Stock">
            </label>
            <label>Fecha de Reguistro: 
                <input type="date" name="FechaRegistro" value="{{date('Y-m-d')}}">
            </label>
            <label>Fecha de Vencimiento: 
                <input type="date" name="FechaVencimiento">
            </label>
            <label>Estado: 
                <input type="text" name="Estado">
            </label>
            <select name="idCategoria" id="idCategoria">
                @foreach ($NomCat as $Nc )
                <option value="{{$Nc->idCategoria}}">{{$Nc->NombreCat}}</option>
                @endforeach
            </select>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="sibmit" class="btn btn-primary">Guardar</button>
        </form>
      </div>
    </div>
  </div>
</div>