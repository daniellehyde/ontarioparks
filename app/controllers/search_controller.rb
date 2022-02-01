class SearchController < ApplicationController
    def search
        @search = Search.new(params[:search])

        @campsites = Campsite
            .includes(:park, :restrictions, :conditions, :adjacent_tos)
            .where(privacy:"Good",quality:"Good")
            .where("max_capacity >= ?", @search.party_size)
            #.where("allowed_equipment like ?", "%#{@search.equipment_type}%")

        restrict(:restrictions)
        restrict(:conditions)
        restrict(:adjacent_tos)
        restrict(:ground_covers)
        restrict(:obstructions)

        if @search.park_ids.any?
            @campsites = @campsites.where(park_id: @search.park_ids)
        end

        pp @search.exclusions
        @campsites = @campsites.reject do |c|
            @search.exclusions.any? do |field, exclude|
                (c.public_send(field).map(&:id) & exclude).any?
            end
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
            conditions: conditions_excluded,
            adjacent_tos: adjacent_tos_excluded,
            ground_covers: ground_covers_excluded,
            obstructions: obstructions_excluded,
        }.select { |k, v| [v.any?] }
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

    def restrictions_excluded; clean_array(:restrictions_excluded); end
    def restrictions_included; clean_array(:restrictions_included); end
    def conditions_excluded; clean_array(:conditions_excluded); end
    def conditions_included; clean_array(:conditions_included); end

    def adjacent_tos_excluded; clean_array(:adjacent_tos_excluded); end
    def adjacent_tos_included; clean_array(:adjacent_tos_included); end

    def ground_covers_excluded; clean_array(:ground_covers_excluded); end
    def ground_covers_included; clean_array(:ground_covers_included); end

    def obstructions_excluded; clean_array(:obstructions_excluded); end
    def obstructions_included; clean_array(:obstructions_included); end

    private

    def clean_array(field)
        params.fetch(field, [])
            .reject(&:blank?)
            .map(&:to_i)
    end
end