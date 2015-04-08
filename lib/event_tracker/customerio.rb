class EventTracker::Customerio
  def initialize(key)
    @key = key
  end

  def init
    <<-EOD
      var _cio = _cio || [];

      (function() {
        var a,b,c;a=function(f){return function(){_cio.push([f].
        concat(Array.prototype.slice.call(arguments,0)))}};b=["identify",
        "track"];for(c=0;c<b.length;c++){_cio[b[c]]=a(b[c])};
        var t = document.createElement('script'),
            s = document.getElementsByTagName('script')[0];
        t.async = true;
        t.id    = 'cio-tracker';
        t.setAttribute('data-site-id', "#{@key}");
        t.src = 'https://assets.customer.io/assets/track.js';
        s.parentNode.insertBefore(t, s);
      })();
    EOD
  end

  def identify(properties)
    %Q{_cio.identify(#{properties.to_json});}
  end

  def track(event_name, properties)
    p = properties.empty? ? "" : ", #{properties.to_json}"
    %Q{_cio.track("#{event_name}"#{p});}
  end
end
