$(document).ready(function() {
    $('.btn-Edit').on('click', function() {
        var id = $(this).val();
        var modalcat = $('#ModalEditCat');
        
        $.ajax({
            type: 'GET',
            url: 'categoria/' + id,
            success: function(res) {
                $(modalcat).find("input[id='idCategoria']").val(res.idCategoria);
                $(modalcat).find("input[id='txtNombrecat']").val(res.NombreCat);
                $(modalcat).modal('show');
            }
        });
    });
});

$(document).ready(function() {
    $('.btn-deletecat').on('click', function() {
        var id = $(this).val();
        var modal = $('#ModalDeletecat');
        
        $.ajax({
            type: 'GET',
            url: 'categoria/' + id,
            success: function(res) {
                $(modal).find("#deleteCat").val(res.idCategoria);
                $(modal).find("#Nom-Cat").text(res.NombreCat);
                $(modal).modal('show');
            }
        });
    });
});