class SearchController < ApplicationController
    def search

        params[:equipment_type] ||= "Single Tent"

        @campsites = Campsite.includes(:park).where(privacy:"Good",quality:"Good")
        if params[:party_size]
            @campsites = @campsites.where("max_capacity >= ?", params[:party_size])
        end
        if params[:equipment_type]
            @campsites = @campsites.where("allowed_equipment like ?", "%#{params[:equipment_type]}%")
        end
        if params[:park_ids].present? && params[:park_ids].any?(&:present?)
            @campsites = @campsites.where(park_id: params[:park_ids])
        end

        @parks = @campsites.map(&:park).uniq
        @subregions = @parks.map(&:subregion).uniq
    end
end
