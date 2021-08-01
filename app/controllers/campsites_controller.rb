class CampsitesController < ApplicationController
    def show
        @campsite = Campsite.find(params[:id])
        @park = @campsite.park
      end
end
