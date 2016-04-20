class CleanerController < ApplicationController

def testcod
end

def posttestcod

puts "vvvv=====#{params[:accept]}"
if params[:accept] == "1"
nogo={'<li> <p>' =>'<li>', '</p> </li>' => '</li>', 
      '<p> </p>' => '','</p>' => "</p>\n", '</li>' => "</li>\n", '</ul>' => "</ul>\n", '</ol>' => "</ol>\n",'</tr>' => "</tr>\n", 
      '<table>' => '<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-curved">', 
      '</table>'=>"</table>\n", '&lt;' => '<', '&gt;'=>'>', '</h1>' => "</h1>\n", '</h2>' => "</h2>\n", 
      '</h3>' => "</h3>\n", '<br>' => '','<p></p>' => '', ' rel="nofollow"' => '', '</td>' =>"</td>\n"}
else
  nogo={'<li> <p>' =>'<li>', '</p> </li>' => '</li>', '<td> <p>' => '<td>', '</p> </td>' => '</td>', 
      '<p> </p>' => '','</p>' => "</p>\n", '</li>' => "</li>\n", '</ul>' => "</ul>\n", '</ol>' => "</ol>\n",'</tr>' => "</tr>\n", 
      '<table>' => '<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-curved">', 
      '</table>'=>"</table>\n", '&lt;' => '<', '&gt;'=>'>', '</h1>' => "</h1>\n", '</h2>' => "</h2>\n", 
      '</h3>' => "</h3>\n", '<br>' => '','<p></p>' => '', ' rel="nofollow"' => '', '</td>' =>"</td>\n"}
end

      

      
      c=params[:content]
       bundle_out=Sanitize.fragment(c,Sanitize::Config.merge(Sanitize::Config::BASIC,
       :elements=> Sanitize::Config::BASIC[:elements]+['table', 'tbody', 'tr', 'td', 'h1', 'h2', 'h3'],
       :attributes=>{'a' => ['href']}) ).split(" ").join(" ")

      re = Regexp.new(nogo.keys.map { |x| Regexp.escape(x) }.join('|'))

      puts "re====#{re}"
      @bundle_out=bundle_out.gsub(re, nogo)

      open_tags= @bundle_out.scan(/</).count
      close_tags= @bundle_out.scan(/<\//).count

      if open_tags/2 == close_tags
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
        @tags=@error
        end
end


end
