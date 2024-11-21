$(document).ready(function(){
}).on('click', '.btn-EditPro', function(){
    var id = $(this).val();
    var modalpro = $('#ModalEditPro');

    $.ajax({
        type: 'GET',
        url: 'producto/' + id,
        success: function(res){
            $(modalpro).find("input[id='EditProducto']").val(res.idProducto)
            $(modalpro).find("input[id='txtNombre']").val(res.NombrePro)
            $(modalpro).find("input[id='txtDescripcion']").val(res.Descripcion)
            $(modalpro).find("input[id='txtPrecio']").val(res.Precio)
            $(modalpro).find("input[id='txtStock']").val(res.Stock)
            $(modalpro).find("input[id='FechaRegistro']").val(res.FechaRegistro)
            $(modalpro).find("input[id='fechaVencimiento']").val(res.FechaVencimiento)
            $(modalpro).find("input[id='txtEstado']").val(res.Estado)
            $(modalpro).find("#idCategoria").val(res.idCategoria).change()
            $(modalpro).modal('show')
        }
    });
});
$(document).ready(function(){

})
.on('click', '.btn-Deletepro', function(){
    var id = $(this).val();
    var modal = $('#ModalDeletePro');

    $.ajax({
        type: 'GET',
        url: 'producto/' + id,
        success: function(res){
            $(modal).find("#idProducto").val(res.idProducto)
            $(modal).find("#res-nomPro").text(res.NombrePro)
            $(modal).modal('show')
        }
    });
});