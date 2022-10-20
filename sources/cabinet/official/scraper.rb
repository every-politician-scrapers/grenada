#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    field :name do
      noko.text.tidy
    end

    field :position do
      noko.xpath('.//following::div[@class="sppb-addon-text"]').first.xpath('.//text()').map(&:text).map(&:tidy).reject(&:empty?)
    end
  end

  class Members
    def member_container
      noko.css('.sppb-feature-box-title')
    end

    def members
      super.reject { |item| item[:position] == 'and' }
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
