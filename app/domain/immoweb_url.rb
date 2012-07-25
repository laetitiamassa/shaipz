class ImmowebUrl
  BASE_URL = "http://www.immoweb.be/fr/searchgo.cfm?mycurrent_Section=buy&xcarte=N&xidcategorie=1&xvpp=Y&xneuf=Y&xmeuble=&xcodepays=B&xdevice=EUR&xorderby1=codecommune&xorderby2=prixhtva&xdisplay=gallery&xinitliste=Y&xadvanced=Y&ongletsearchactif=1&xframeheight=1276"

  def initialize(budget, building_type, minimum_space, zipcodes)
    @budget = budget
    @building_type = building_type
    @minimum_space = minimum_space
    @zipcodes = zipcodes
  end

  def self.generate_search_url(budget, building_type, minimum_space, zipcodes)
    immoweb_url = new(budget, building_type, minimum_space, zipcodes)
    [BASE_URL, immoweb_url.building_type, immoweb_url.minimum_space, immoweb_url.maximum_price, immoweb_url.zipcodes].join
  end

  def building_type
    case @building_type
      when "house"
        "&xtypelocation=N"
      when "rental_complex"
        "&xtypelocation=&ximmeublerapport=Y&ximmeublerapport=Y&xshow=rapport"
      else
        ""
    end
  end

  def minimum_space
    "&xsurfacehabitabletotale1=#{@minimum_space}"
  end

  def maximum_price
    "&xprice2=#{@budget}"
  end

  def zipcodes
    zipcode_query = ""
    @zipcodes[0..3].each_with_index do |zipcode, index|
      commune_index = index.succ
      zipcode_query += "&xcodecommune#{commune_index}=#{zipcode}"
    end
    zipcode_query
  end
end
