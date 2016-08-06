class AddMoreIndexesToActivitiesAndTagsAndLocations < ActiveRecord::Migration[5.0]
  def up
    execute("COMMIT")

    begin
      execute %(CREATE EXTENSION IF NOT EXISTS btree_gin)
    rescue => e
      if PG::InsufficientPrivilege === e.cause
        Rails.logger.warn %(Could not create btree_gin extension)
        return
      end
    end

    begin
      execute %(CREATE EXTENSION IF NOT EXISTS pg_trgm)
    rescue => e
      if PG::InsufficientPrivilege === e.cause
        Rails.logger.warn %(Could not create pg_trgm extension)
        return
      end
    end

    add_index :activities, :title, using: :gin
    add_index :activities, :about, using: :gin

    add_index :tags, :title, using: :gin

    add_index :locations, :name, using: :gin
    add_index :locations, :city, using: :gin
  end

  def down
    remove_index :activities, :title
    remove_index :activities, :about

    remove_index :tags, :title

    remove_index :locations, :name
    remove_index :locations, :city
    execute("COMMIT")

    begin
      execute %(DROP EXTENSION btree_gin)
    rescue => e
      if PG::InsufficientPrivilege === e.cause
        Rails.logger.warn %(Could not drop btree_gin extension)
        return
      end
    end

    begin
      execute %(DROP EXTENSION pg_trgm)
    rescue => e
      if PG::InsufficientPrivilege === e.cause
        Rails.logger.warn %(Could not drop pg_trgm extension)
        return
      end
    end
  end
end
