# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_05_062422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.text "content", null: false
    t.string "activity_name", null: false
    t.string "additional_info"
    t.bigint "user_id"
    t.string "cost", null: false
    t.string "addressLN1", null: false
    t.string "addressLN2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.string "picture"
    t.string "capacity", null: false
    t.string "contact_number"
    t.string "contact_email", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "weekly_recurring"
    t.string "recurring_schedule"
    t.index ["user_id", "created_at"], name: "index_activities_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "activity_tickets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "spots_buying"
    t.index ["activity_id"], name: "index_activity_tickets_on_activity_id"
    t.index ["user_id"], name: "index_activity_tickets_on_user_id"
  end

  create_table "appointment_tickets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "appointment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "appointment_id"], name: "index_appointment_tickets_on_user_id_and_appointment_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.integer "service_id"
    t.string "client_contact_number"
    t.string "client_contact_email"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text "description"
    t.string "booked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_appointments_on_service_id"
  end

  create_table "booking_venues", force: :cascade do |t|
    t.integer "activity_id"
    t.integer "venue_id"
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_booking_venues_on_activity_id"
    t.index ["venue_id"], name: "index_booking_venues_on_venue_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "digits", null: false
    t.string "exp_date", null: false
    t.string "cvv", null: false
    t.string "bill_zipcode", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_name"], name: "index_categories_on_category_name", unique: true
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.integer "activity_id"
    t.string "topic"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_chatrooms_on_activity_id"
  end

  create_table "connect_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "user_chatroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_chatroom_id"], name: "index_connect_users_on_user_chatroom_id"
    t.index ["user_id"], name: "index_connect_users_on_user_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.integer "chatroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "read"
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "activity_id", null: false
    t.integer "stars", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_ratings_on_activity_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "read_messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_read_messages_on_user_id"
  end

  create_table "rental_ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "rental_id"
    t.string "stars"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rental_id"], name: "index_rental_ratings_on_rental_id"
    t.index ["user_id"], name: "index_rental_ratings_on_user_id"
  end

  create_table "rental_tickets", force: :cascade do |t|
    t.integer "rental_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "days_renting"
    t.index ["rental_id"], name: "index_rental_tickets_on_rental_id"
    t.index ["user_id"], name: "index_rental_tickets_on_user_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.string "cost", null: false
    t.string "rental_name", null: false
    t.text "description", null: false
    t.string "category"
    t.text "additional_info"
    t.string "contact_number"
    t.string "contact_email", null: false
    t.string "addressLN1", null: false
    t.string "addressLN2"
    t.string "state", null: false
    t.string "city", null: false
    t.string "zipcode", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rentals_on_user_id"
  end

  create_table "service_tags", force: :cascade do |t|
    t.integer "service_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_service_tags_on_category_id"
    t.index ["service_id"], name: "index_service_tags_on_service_id"
  end

  create_table "service_tickets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "service_id"
    t.datetime "service_time"
    t.string "day"
    t.string "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_service_tickets_on_service_id"
    t.index ["user_id"], name: "index_service_tickets_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.text "content", null: false
    t.string "service_name", null: false
    t.string "additional_info"
    t.bigint "user_id"
    t.string "cost", null: false
    t.string "addressLN1", null: false
    t.string "addressLN2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.string "capacity"
    t.string "contact_number"
    t.string "contact_email"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text "recurring_schedule"
    t.string "travel_options"
    t.string "availability_days", null: false
    t.string "availability_hours", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_services_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "stripe_connects", force: :cascade do |t|
    t.integer "user_id"
    t.integer "account_id"
    t.string "external_account"
    t.string "city"
    t.string "address_line1"
    t.string "postal_code"
    t.string "state"
    t.string "dob_day"
    t.string "dob_month"
    t.string "dob_year"
    t.string "first_name"
    t.string "last_name"
    t.string "ssn_last_4"
    t.string "legal_entity_type"
    t.datetime "acceptance_date"
    t.string "acceptance_ip"
    t.string "personal_id_number"
    t.string "verification_document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "accountId"
    t.string "account_number"
    t.string "routing_number"
    t.index ["user_id"], name: "index_stripe_connects_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.integer "activity_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_tags_on_activity_id"
    t.index ["category_id"], name: "index_tags_on_category_id"
  end

  create_table "user_chatrooms", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_messages", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.integer "user_chatroom_id"
    t.string "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_chatroom_id"], name: "index_user_messages_on_user_chatroom_id"
    t.index ["user_id"], name: "index_user_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "profession"
    t.text "skills"
    t.text "about"
    t.string "facebook"
    t.string "instagram"
    t.string "youtube"
    t.string "pinterest"
    t.string "twitter"
    t.boolean "agree_to_terms"
    t.boolean "agree_to_privacy"
    t.string "routing_number"
    t.string "account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.text "about_me"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "account_activated"
    t.string "account_activation_secret"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "reset_password_secret"
    t.string "email_list"
    t.string "locked"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "venue_name", null: false
    t.string "address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.integer "user_id"
    t.integer "price", null: false
    t.string "capacity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_venues_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "services", "users"
end
