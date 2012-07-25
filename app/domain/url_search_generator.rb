
class UrlSearchGenerator
  def initialize(search_engine)
    @search_engine = search_engine
  end

  def url (max_price, zipcode, surface)
    @url = Array.new
    budget_required = budget_searched(max_price)
    types_building = type_building(surface)
    surface_building = surface_for_building(surface)
    types_building.each do |type|
      case @search_engine
        when "immoweb"
          @url << ImmowebUrl::URL + ImmowebUrl.type_building(type) + ImmowebUrl.minimum_space(surface_building)+ ImmowebUrl.maximum_price(budget_required) + ImmowebUrl.zipcode(zipcode)
      end
    end
    @url
  end

  def can_have_a_house?(surface)
    surface >= 70
  end

  def type_building (surface)
    types = ["rental_complex"]
    if can_have_a_house?(surface)
      types.push("house")
    end
    types
  end

  def budget_searched (max_price)
    if max_price<150000
      return max_price * 5
    elsif max_price <350000
      return max_price * 7
    else
      return max_price * 5
    end
  end

  def surface_for_building (surface)
    if surface < 100
      return surface * 3
    elsif surface >= 100
      return surface * 2.2
    end
  end
end

