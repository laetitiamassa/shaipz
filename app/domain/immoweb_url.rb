class ImmowebUrl
  URL = "http://www.immoweb.be/fr/searchgo.cfm?mycurrent_Section=buy&xcarte=N&xidcategorie=1&xvpp=Y&xneuf=Y&xmeuble=&xcodepays=B&xdevice=EUR&xorderby1=codecommune&xorderby2=prixhtva&xdisplay=gallery&xinitliste=Y&xadvanced=Y&ongletsearchactif=1&xframeheight=1276"

  def self.type_building (type)
    case type
      when "house"
        return "&xtypelocation=N"
      when "rental_complex"
        return "&xtypelocation=&ximmeublerapport=Y&ximmeublerapport=Y&xshow=rapport"
      else
        return ""
    end
  end

  def self.minimum_space (min_space)
    "&xsurfacehabitabletotale1=#{min_space}"
  end

  def self.maximum_price (max_price)
    "&xprice2=#{max_price}"
  end

  def self.zipcode(zipcodes)
    zipcode_query = ""
    zipcodes[0..3].each_with_index do |zipcode, index|
      commune_index = index.succ
      zipcode_query += "&xcodecommune#{commune_index}=#{zipcode}"
    end
    zipcode_query
  end
end