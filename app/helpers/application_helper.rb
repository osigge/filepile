module ApplicationHelper        

  def title_tag
	  elements = ['FilePile']
	  content_tag :title, elements.join(' &raquo; ')
	end
	
  def callback
    return if flash.keys.empty?
    
    if flash[:error]
      content = content_tag :h2, flash[:error], :class => 'error', :id => 'flash'
    elsif flash[:warn]
      content = content_tag :h2, flash[:warn], :class => 'warn', :id => 'flash' 
    else
      content = content_tag :h2, flash[:notice], :class => 'notice', :id => 'flash'
    end
    
    flash.discard
    
    script  = content_tag :script, "new Effect.Pulsate('flash'); setTimeout(\"new Effect.Fade('flash');\", 3000)", :type => 'text/javascript'
    
    "#{content}\r\n#{script}"
  end
end
