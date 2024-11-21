<div class="modal fade" id="ModalDeletePro" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Eliminar Producto</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="{{url('EliminarPro')}}" method="post">
            @csrf
            @method('DELETE')
            <input type="hidden" id="idProducto" name="idProducto" >
            <p>¿estas seguro de querer eliminar la categoria de <strong id="res-nomPro"></strong>?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="sibmit" class="btn btn-danger">Eliminar</button>
        </form>
      </div>
    </div>
  </div>
</div>