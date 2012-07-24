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

  def self.zipcode (zipcodes)
    "&xcodecommune1=#{zipcodes[0]}&xcodecommune2=#{zipcodes[1]}&xcodecommune3=#{zipcodes[2]}&xcodecommune4=#{zipcodes[3]}"
  end
end