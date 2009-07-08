class CreateGlobalizeLanguages < ActiveRecord::Migration
  def self.up
    create_table "globalize_languages", :force => true do |t|
      t.column "iso_639_1",             :string,  :limit => 2
      t.column "iso_639_2",             :string,  :limit => 3
      t.column "iso_639_3",             :string,  :limit => 3
      t.column "rfc_3066",              :string
      t.column "english_name",          :string
      t.column "english_name_locale",   :string
      t.column "english_name_modifier", :string
      t.column "native_name",           :string
      t.column "native_name_locale",    :string
      t.column "native_name_modifier",  :string
      t.column "macro_language",        :boolean
      t.column "direction",             :string
      t.column "pluralization",         :string
      t.column "scope",                 :string,  :limit => 1
    end

    add_index "globalize_languages", ["iso_639_1"], :name => "index_globalize_languages_on_iso_639_1"
    add_index "globalize_languages", ["iso_639_2"], :name => "index_globalize_languages_on_iso_639_2"
    add_index "globalize_languages", ["iso_639_3"], :name => "index_globalize_languages_on_iso_639_3"
    add_index "globalize_languages", ["rfc_3066"], :name => "index_globalize_languages_on_rfc_3066"

  end

  def self.down
    drop_table :globalize_languages
  end
end
