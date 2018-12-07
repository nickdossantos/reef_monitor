$(document).on('turbolinks:load', function(){
  $('#dashboardModal').on('shown.bs.modal', function () {
    $('#myInput').trigger('focus')
  })
}
