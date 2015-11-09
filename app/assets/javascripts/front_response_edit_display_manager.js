function FrontResponseEditDisplayManager (argument) {
  this.$frontsContainer = $('.' + argument.frontsContainerClass);
  this.$frontElements = this.$frontsContainer.find('.' + argument.frontElementsClass);
  this.$frontEditResponseTextboxes = this.$frontsContainer.find('.textarea-edit-response');
  this.$showFrontsButton = this.$frontsContainer.find('#' + argument.showFrontsButtonId);
  this.$frontEditResponseButtons = this.$frontsContainer.find('.' + argument.frontEditResponseButtonsClass);
  this.$updateButtons = this.$frontsContainer.find('.' + argument.updateButtonsClass);
  this.frontElementsClass = argument.frontElementsClass;
  this.responseElementClass = argument.responseElementClass;
  this.updateButtonsClass = argument.updateButtonsClass;
}

FrontResponseEditDisplayManager.prototype.init = function() {
  this.bindEvents();
}

FrontResponseEditDisplayManager.prototype.bindEvents = function() {
  this.bindResponseEditButton();
  this.bindShowFrontsButton();
}

FrontResponseEditDisplayManager.prototype.bindResponseEditButton = function() {
  this.$frontEditResponseTextboxes.hide();
  this.$updateButtons.hide();
  var _this = this;
  this.$frontEditResponseButtons.on('mousedown', function(){
    var $this = $(this);
    var parentFrontContainer = $(this.closest('.' + _this.frontElementsClass));

    var elements = _this.$frontElements.not(parentFrontContainer);
    elements.hide();
    parentFrontContainer.removeClass('col-md-4').addClass('col-md-10').hide();
    parentFrontContainer.show('slide',{direction:'left'}, 300);
    var parentResponseContainer = $(this.closest('.' + _this.responseElementClass));

    /* change for adding Frola editor
    // parentResponseContainer.find('textarea').froalaEditor({
    //   height: 100,
    //   imageAllowedTypes: ['jpeg', 'jpg', 'png']
    // });
    // $('.fr-box').show();
    parentResponseContainer.find('.' + _this.updateButtonsClass).show();
    $this.hide();

    end */

    /* change */
      parentResponseContainer.find('textarea').show();
    /* end */

    _this.$showFrontsButton.show();
  });
}

FrontResponseEditDisplayManager.prototype.bindShowFrontsButton = function() {
  this.$showFrontsButton.hide();
  var _this = this;
  this.$showFrontsButton.on('mousedown', function(){
    // $('.fr-box').hide();
    _this.$frontElements.removeClass('col-md-10').
                          addClass('col-md-4').
                          hide().show();
    // _this.$frontEditResponseTextboxes.show();
    _this.$updateButtons.hide();
    $(this).hide();
  });
}

$(function() {
  var argument = { frontsContainerClass: 'motion-fronts',
                    frontElementsClass: 'fronts',
                    responseElementClass: 'response-container',
                    showFrontsButtonId: 'show-fronts-button',
                    frontEditResponseButtonsClass: 'response-edit-button',
                    updateButtonsClass: 'update-response-button' };

  var obj1 = new FrontResponseEditDisplayManager(argument);
  obj1.init();
});
