class SearchController < ApplicationController
    def search
        @search = Search.new(params[:search])

        @campsites = Campsite
            .includes(:park, :restrictions, :equipment)
            .where(privacy:"Good", quality:"Good")
            .where("max_capacity >= ?", @search.party_size)
            .left_outer_joins(:equipment)
            .where(equipment: @search.equipment_type)

        if @search.park_ids.any?
            @campsites = @campsites.where(park_id: @search.park_ids)
        end

        @campsites = @campsites.select do |c|
            actual = Set.new(c.restrictions.map(&:id))
            required = Set.new(@search.restrictions_included)
            required.subset?(actual)
        end

        @campsites = @campsites.reject do |c|
            excluded = @search.restrictions_excluded
            actual = c.restrictions.map(&:id)
            (excluded & actual).any?
        end

        @parks = @campsites.map(&:park).uniq
        @subregions = @parks.map(&:subregion).uniq
    end

    private

    def restrict(field)
        field_method = "#{field}_included".to_sym
        values = @search.public_send(field_method)
        if values.any?
            @campsites = @campsites
                .left_outer_joins(field)
                .where(field => values)
        end
    end
end

class Search
    attr_reader :params

    def initialize(params)
        @params = params || {}
    end

    def exclusions
        {
            restrictions: restrictions_excluded,
        }.select { |k, v| [v.any?] }
    end

    def park_ids
        clean_array(:park_ids)
    end

    def party_size
        params.fetch(:party_size, 1)
    end

    def equipment_type
        params.fetch(:equipment_type, Equipment.first)
    end

    def restrictions_excluded; clean_array(:restrictions_excluded); end
    def restrictions_included; clean_array(:restrictions_included); end

    private

    def clean_array(field)
        params.fetch(field, [])
            .reject(&:blank?)
            .map(&:to_i)
    end
end