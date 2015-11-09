function FrontResponseDisplayManager (argument) {
  this.$frontsContainer = $('.' + argument.frontsContainerClass);
  this.$frontElements = this.$frontsContainer.find('.' + argument.frontElementsClass);
  this.$frontResponseTextboxes = this.$frontsContainer.find('.textarea-create-response');
  this.$showFrontsButton = this.$frontsContainer.find('#' + argument.showFrontsButtonId);
  this.frontElementsClass = argument.frontElementsClass;
}

FrontResponseDisplayManager.prototype.init = function() {
  this.bindEvents();
}

FrontResponseDisplayManager.prototype.bindEvents = function() {
  this.bindResponseFocus();
  this.bindShowFrontsButton();
}

FrontResponseDisplayManager.prototype.bindResponseFocus = function() {
  var _this = this;
  this.$frontResponseTextboxes.focus(function(){
    var $this = $(this);
    var parentFrontContainer = $(this.closest('.' + _this.frontElementsClass));

    var elements = _this.$frontElements.not(parentFrontContainer);
    elements.hide();
    parentFrontContainer.removeClass('col-md-4').addClass('col-md-10').hide();
    parentFrontContainer.show('slide',{direction:'left'}, 300);
    // $this.froalaEditor({
    //   height: 100,
    //   imageAllowedTypes: ['jpeg', 'jpg', 'png']
    // });
    // $('.fr-box').show();
    // $this.hide();
    _this.$showFrontsButton.show();
  });
}

FrontResponseDisplayManager.prototype.bindShowFrontsButton = function() {
  this.$showFrontsButton.hide();
  var _this = this;
  this.$showFrontsButton.on('mousedown', function(){
    // $('.fr-box').hide();
    _this.$frontElements.removeClass('col-md-10').
                          addClass('col-md-4').
                          hide().show();
    _this.$frontResponseTextboxes.show();
    $(this).hide();
  });
}

$(function() {
  // var argument = { frontsContainerClass: 'motion-fronts',
  //                   frontElementsClass: 'fronts',
  //                   showFrontsButtonId: 'show-fronts-button' };

  // var obj1 = new FrontResponseDisplayManager(argument);
  // obj1.init();

  // var obj1 = new PopupFormGeneratorEngine();
  // obj1.init();
  // obj1.appendPopupContainer($('body'));
});
