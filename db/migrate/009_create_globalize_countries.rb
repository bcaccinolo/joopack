class CreateGlobalizeCountries < ActiveRecord::Migration
  def self.up
    create_table "globalize_countries", :force => true do |t|
      t.column "code",                   :string, :limit => 2
      t.column "english_name",           :string
      t.column "date_format",            :string
      t.column "currency_format",        :string
      t.column "currency_code",          :string, :limit => 3
      t.column "thousands_sep",          :string, :limit => 2
      t.column "decimal_sep",            :string, :limit => 2
      t.column "currency_decimal_sep",   :string, :limit => 2
      t.column "number_grouping_scheme", :string
    end

    add_index "globalize_countries", ["code"], :name => "index_globalize_countries_on_code"

  end

  def self.down
    drop_table :globalize_countries
  end
end
