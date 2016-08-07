SELECT
  activities.id AS searchable_id,
  CAST ('Activity' AS varchar) AS searchable_type,
  activities.title AS searchable_title,
  activities.about AS searchable_about,
  activities.camp AS searchable_camp,
  activities.indoor AS searchable_indoor,
  activities.outdoor AS searchable_outdoor,
  activities.drop_in AS searchable_drop_in,
  activities.date_night AS searchable_date_night,
  activities.title || activities.about AS the_text
FROM activities
