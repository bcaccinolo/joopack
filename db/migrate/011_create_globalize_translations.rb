class CreateGlobalizeTranslations < ActiveRecord::Migration
  def self.up
    create_table "globalize_translations", :force => true do |t|
      t.column "type",                :string
      t.column "tr_key",              :string
      t.column "table_name",          :string
      t.column "item_id",             :integer
      t.column "facet",               :string
      t.column "built_in",            :boolean, :default => true
      t.column "language_id",         :integer
      t.column "pluralization_index", :integer
      t.column "text",                :text
      t.column "namespace",           :string
    end

    add_index "globalize_translations", ["tr_key", "language_id"], :name => "index_globalize_translations_on_tr_key_and_language_id"
    add_index "globalize_translations", ["table_name", "item_id", "language_id"], :name => "globalize_translations_table_name_and_item_and_language"
  end

  def self.down
    drop_table :globalize_translations
  end
end
