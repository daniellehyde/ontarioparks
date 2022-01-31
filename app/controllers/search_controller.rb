class SearchController < ApplicationController
    def search
        @search = Search.new(params[:search])

        @campsites = Campsite
            .includes(:park, :restrictions)
            .where(privacy:"Good",quality:"Good")
            .where("max_capacity >= ?", @search.party_size)
            .where("allowed_equipment like ?", "%#{@search.equipment_type}%")

        if @search.restrictions_included.any?
            @campsites = @campsites
                .left_outer_joins(:restrictions)
                .where(restrictions: @search.restrictions_included)
        end

        if @search.park_ids.any?
            @campsites = @campsites.where(park_id: @search.park_ids)
        end

        if @search.restrictions_excluded.any?
            @campsites = @campsites
                .reject { |c| (c.restrictions.map(&:id) & @search.restrictions_excluded).any? }
        end

        @parks = @campsites.map(&:park).uniq
        @subregions = @parks.map(&:subregion).uniq
    end
end

class Search
    attr_reader :params

    def initialize(params)
        @params = params || {}
    end

    def park_ids
        clean_array(:park_ids)
    end

    def party_size
        params.fetch(:party_size, 1)
    end

    def equipment_type
        params.fetch(:equipment_type, "Single Tent")
    end

    def restrictions_excluded
        clean_array(:restrictions_excluded)
    end

    def restrictions_included
        clean_array(:restrictions_included)
    end

    private

    def clean_array(field)
        params.fetch(field, [])
            .reject(&:blank?)
            .map(&:to_i)
    end
end