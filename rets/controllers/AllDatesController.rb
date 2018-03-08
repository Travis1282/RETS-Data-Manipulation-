class AllDatesController < ApplicationController

get '/' do
    dates = Property.distinct.pluck("datesold")

        # binding.pry
    sorted = dates.sort
    sorted.to_json

  end

end