document.observe('dom:loaded', function(){
  if($('slides')) observeImageElements();
});

function observeImageElements() {
  $$('ul.image-links li a.add', 'ul.image-links li a.remove').invoke('observe', 'click', setImageState);
  $$('.img-details .formfield input[type=text]').invoke('observe', 'blur', reorderImages);
  $$('.img-details .formfield select').invoke('observe', 'change', attachToFeature);
}

function setImageState(e) {
  e.stop();
  var el = Event.element(e),
      href = el.readAttribute('href'),
      enable = el.hasClassName('add'),
      parent = el.up('.images') || el.up('.section');

  if(!el.hasClassName('disabled')) {
    new Ajax.Updater(parent, href, {
      method: 'put',
      parameters: {enable: enable},
      onComplete: function(transport) {
        observeImageElements();
      }
    });
  }
}

function reorderImages(e) {
  console.log('reorderImages!');
  var el = Event.element(e),
      val = el.value,
      previous = el.readAttribute('data_position'),
      url = el.readAttribute('data_url'),
      parent = el.up('.images') || el.up('.section');
      
  if(val != previous) {
    console.log('val != previous');
    new Ajax.Updater(parent, url, {
      method: 'put',
      parameters: {position: val},
      onComplete: function(transport) {
        observeImageElements();
      }
    });
  }
}


function attachToFeature(e) {
  var el = Event.element(e),
      selected = el.value,
      image = el.up('li').identify().sub("image-", ""),
      refresh = el.up('.rightcol'),
      msg = "Are you sure you wish to connect this image to the selected feature?"

  if(selected) {
    if(confirm(msg)) {
      new Ajax.Request('/features/attach_image',{
        method: 'put',
        parameters: {image: image, to: selected},
        onComplete: function(transport) {
          var json = transport.responseText.evalJSON();
          if(json.valid) {
            refresh.replace(json.output);
            observeImageElements();
          }
        }
      });
    }
  }
}
