class UrlSearchGenerator
  def initialize(search_engine, user)
    @search_engine = search_engine
    @user = user
  end

  def generate_urls
    urls = []
    building_types.each do |building_type|
      case @search_engine
        when "immoweb"
          urls << ImmowebUrl.generate_search_url(searched_budget, building_type, searched_space, searched_areas)
      end
    end
    urls
  end

  def building_types
    types = ["rental_complex"]
    types.push("house") if user_can_have_a_house?
    types
  end

  def searched_budget
    maximum_budget = @user.maximum_budget
    if maximum_budget.between?(150000, 350000)
      maximum_budget * 7
    else
      maximum_budget * 5
    end
  end

  def searched_space
    minimum_space = @user.minimum_space
    space = minimum_space < 100 ? minimum_space * 3 : minimum_space * 2.2
    space.to_i
  end

  def searched_areas
    @user.zipcodes
  end

  def user_can_have_a_house?
    @user.minimum_space >= 70
  end
end
