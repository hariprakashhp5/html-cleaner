class CleanerController < ApplicationController

def testcod
end

def test
end
# def posttestcod

# if params[:accept] == "1"
#       path=["//ul/li/p","//ol/li/p"]
# else
#       path=["//table/tbody/tr/td/p", "//ul/li/p","//ol/li/p"]
# end

#     nogo={'<p> </p>' => '', 
#       '<table>' => "\n<table width='100%' border='0' cellspacing='0' cellpadding='0' class='table table-curved'>", 
#      '&lt;' => '<', '&gt;'=>'>','<br>' => '','<p></p>' => '', ' rel="nofollow"' => '', "http://www.bankbazaar.com"=>"",
#         "https://www.bankbazaar.com"=>"",'<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">'=>"",
#           "<html><body>"=>"","</body></html>"=>""}  

      
#       c=params[:content]
#        bundle_out=Sanitize.fragment(c,Sanitize::Config.merge(Sanitize::Config::BASIC,
#        :elements=> Sanitize::Config::BASIC[:elements]+['table', 'tbody', 'tr', 'td', 'h1', 'h2', 'h3'],
#        :attributes=>{'a' => ['href']}) )

#       re = Regexp.new(nogo.keys.map { |x| Regexp.escape(x) }.join('|'))

#       puts "re====#{re}"
#       intr=bundle_out.gsub(re, nogo)

#       doc=Nokogiri::HTML.parse(intr)
      
#       path.each do |p|
#         puts p
#         doc.xpath(p).each do |pp|
#           pp.replace(pp.to_html)
#         end
#       end
#       filter=doc.to_html
#       @bundle_out=filter.gsub(re,nogo)


#       open_tags= @bundle_out.scan(/</).count
#       close_tags= @bundle_out.scan(/<\//).count

#       if open_tags/2 == close_tags
#         @tags=["Open and close tags are equal"]
#       else
#         @p=@bundle_out.scan(/<p/).count
#         @cp=@bundle_out.scan(/<\/p/).count
#         @li=@bundle_out.scan(/<li/).count
#         @cli=@bundle_out.scan(/<\/li/).count
#         @ul=@bundle_out.scan(/<ul/).count
#         @cul=@bundle_out.scan(/<\/ul/).count
#         @ol=@bundle_out.scan(/<ol/).count
#         @col=@bundle_out.scan(/<\/ol/).count
#         @tab=@bundle_out.scan(/<table/).count
#         @ctab=@bundle_out.scan(/<\/table/).count
#         @tr=@bundle_out.scan(/<tr/).count
#         @ctr=@bundle_out.scan(/<\/tr/).count
#         @td=@bundle_out.scan(/<td/).count
#         @ctd=@bundle_out.scan(/<\/td/).count

#         arr=[[@li,@cli,'li'],[@ul,@cul,'ul'],[@ol,@col,'ol'],[@p,@cp,'p'],[@tab,@ctab,'table'],[@tr,@ctr,'tr'],[@td,@ctd,'td']]
#         bar=[] #initializing empty array to appand the results
#         for i in 0..arr.count-1
#         if arr[i][0] != arr[i][1]
#         var=arr[i][2]+"="+arr[i][0].to_s+"|"+arr[i][1].to_s
#         @error=bar<<var
#         end
#         end
#         @tags=@error
#         end
# end

def htmraw

end

def posttestcod

puts "vvvv=====#{params[:accept]}"

# if params[:accept] == "1"
# nogo={"<li>\n<p>" =>'<li>', "</p>\n</li>" => '</li>', 
#       '<p> </p>' => '', '<ul>' => "\n<ul>", '</ul>' => "</ul>\n", '</ol>' => "</ol>\n", 
#       '<table>' => "\n<table width='100%' border='0' cellspacing='0' cellpadding='0' class='table table-curved'>", 
#       '<br>' => '','<p></p>' => '', ' rel="nofollow"' => '',
#       "https://www.bankbazaar.com"=>"", "http://www.bankbazaar.com"=>""}
# else
#   nogo={"<li>\n<p>" =>'<li>', "</p>\n</li>" => '</li>', "<td>\n<p>" => '<td>', "</p>\n</td>" => '</td>', 
#       '<p> </p>' => '','<ul>' => "\n<ul>",'</ul>' => "</ul>\n", '</ol>' => "</ol>\n",
#       '<table>' => "\n<table width='100%' border='0' cellspacing='0' cellpadding='0' class='table table-curved'>", 
#      '<br>' => '','<p></p>' => '', ' rel="nofollow"' => '', 
#      "https://www.bankbazaar.com"=>"", "http://www.bankbazaar.com"=>""}
# end

# nogotwo={'&amp;'=>'&', '&lt;' => '<', '&gt;'=>'>'}

# if params[:accept] == "1"
# nogo={"<li>\n<p>" =>'<li>', "</p>\n</li>" => '</li>'}
# else
#   nogo={"<li>\n<p>" =>'<li>', "</p>\n</li>" => '</li>', "<td>\n<p>" => '<td>', "</p>\n</td>" => '</td>'}
# end

#######################----BB-FILTERS----######################
if params[:accept] == "1"
  filterone={"<li>\n<p>" =>'<li>',"</p>\n</li>" => '</li>','<br>' => ''}
else
  filterone={"<li>\n<p>" =>'<li>', "</p>\n</li>" => '</li>', "<td>\n<p>" => '<td>', "</p>\n</td>" => '</td>', '<br>' => ''}
end
      
  filtertwo={'&amp;'=>'&', '&lt;' => '<', '&gt;'=>'>','<p> </p>' => '','<ul>' => "\n<ul>",'</ul>' => "</ul>\n", '</ol>' => "</ol>\n",
           '<table>' => "\n<table width='100%' border='0' cellspacing='0' cellpadding='0' class='table table-curved'>", 
           '<br>' => '','<p></p>' => '', ' rel="nofollow"' => '', "https://www.bankbazaar.com"=>"", "http://www.bankbazaar.com"=>"", 
           '<h2><strong>'=>'<h2>','</strong></h2>'=>'</h2>','<h1><strong>'=>'<h1>', '</strong></h1>'=>'</h1>','<h3><strong>'=>'h3',
           '</strong></h3>'=>'</h3>'}
#############################################################

    #####################----MAIN HTML CONVERSION CODE----######################  
      c=params[:content]
       bundle_out=Sanitize.fragment(c,Sanitize::Config.merge(Sanitize::Config::BASIC,
       :elements=> Sanitize::Config::BASIC[:elements]+['table', 'tbody', 'tr', 'td', 'h1', 'h2', 'h3']))#.split(" ").join(" ")
    ############################################################################


####################----BB FORMATING IS HAPPENING THROUGH BELOW CODES----#########################
      re = Regexp.new(filterone.keys.map { |x| Regexp.escape(x) }.join('|')) 
      inter=bundle_out.gsub(re, filterone) #bb format is being done here
      doc=Nokogiri::HTML.fragment(inter) #to take care of mismatched open and close tags
      fltrd1=doc.inner_html
      fltrd2=fltrd1.gsub(/<(\w+)(?:\s+\w+="[^"]+(?:"\$[^"]+"[^"]+)?")*>\s*<\/\1>/,"")#to remove empty p tags
      rex= Regexp.new(filtertwo.keys.map { |x| Regexp.escape(x) }.join('|')) 
      @bundle_out=fltrd2.gsub(rex, filtertwo) #FINAL OUTPUT
      gon.products=@bundle_out 
##################################################################################################

####################----TAG COUNT----#####################
      open_tags= @bundle_out.scan(/</).count
      close_tags= @bundle_out.scan(/<\//).count

      if open_tags.to_f/2 == close_tags.to_f
        @tags=["Open and close tags are equal"]
      else
        @p=@bundle_out.scan(/<p/).count
        @cp=@bundle_out.scan(/<\/p/).count
        @li=@bundle_out.scan(/<li/).count
        @cli=@bundle_out.scan(/<\/li/).count
        @ul=@bundle_out.scan(/<ul/).count
        @cul=@bundle_out.scan(/<\/ul/).count
        @ol=@bundle_out.scan(/<ol/).count
        @col=@bundle_out.scan(/<\/ol/).count
        @tab=@bundle_out.scan(/<table/).count
        @ctab=@bundle_out.scan(/<\/table/).count
        @tr=@bundle_out.scan(/<tr/).count
        @ctr=@bundle_out.scan(/<\/tr/).count
        @td=@bundle_out.scan(/<td/).count
        @ctd=@bundle_out.scan(/<\/td/).count

        arr=[[@li,@cli,'li'],[@ul,@cul,'ul'],[@ol,@col,'ol'],[@p,@cp,'p'],[@tab,@ctab,'table'],[@tr,@ctr,'tr'],[@td,@ctd,'td']]
        bar=[] #initializing empty array to appand the results
        for i in 0..arr.count-1
        if arr[i][0] != arr[i][1]
        var=arr[i][2]+"="+arr[i][0].to_s+"|"+arr[i][1].to_s
        @error=bar<<var
        end
        end
        @tags=@error #FINAL O/P FOR TAG COUNT
        end
###########################################################
end


end
