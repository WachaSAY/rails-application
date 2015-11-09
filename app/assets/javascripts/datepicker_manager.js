function DatepickerManager (argument) {
  this.$body = $('body');
  this.$datepickerElement = this.$body.find('.' + argument.datepickerElementClass);
};

DatepickerManager.prototype.init = function() {
  this.bindDatepicker();
};

DatepickerManager.prototype.bindDatepicker = function() {
  this.$datepickerElement.datetimepicker({
    format: 'YYYY-MM-DD'
  });
}

$(function(){
  var argument = { datepickerElementClass: 'datepicker-element' };
  var obj1 = new DatepickerManager(argument);
  obj1.init();
});
