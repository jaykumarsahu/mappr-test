# This migration comes from acts_as_taggable_on_engine (originally 6)
if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class AddMissingIndexesOnTaggings < ActiveRecord::Migration[4.2]; end
else
  class AddMissingIndexesOnTaggings < ActiveRecord::Migration; end
end

AddMissingIndexesOnTaggings.class_eval do
  def change
    %i[tag_id taggable_id taggable_type tagger_id context].each do |column_name|
      add_index(:taggings, column_name) unless index_exists?(:taggings, column_name)
    end

    add_index :taggings, %i[tagger_id tagger_type] unless index_exists? :taggings, %i[tagger_id tagger_type]

    return if index_exists? :taggings, %i[taggable_id taggable_type tagger_id context], name: 'taggings_idy'

    add_index :taggings, %i[taggable_id taggable_type tagger_id context], name: 'taggings_idy'
  end
end
