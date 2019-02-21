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

ActiveRecord::Schema.define(version: 2019_02_20_012759) do

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

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "discussion_id"
    t.bigint "parent_id"
    t.bigint "lesson_id"
    t.integer "upvote", default: 1
    t.integer "downvote", default: 0
    t.index ["discussion_id"], name: "index_comments_on_discussion_id"
    t.index ["lesson_id"], name: "index_comments_on_lesson_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "communities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identifier"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.string "course_info"
    t.string "instructor_bio"
    t.string "keywords"
    t.boolean "published"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "community_id"
    t.boolean "open"
    t.string "type"
    t.index ["community_id"], name: "index_courses_on_community_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "community_id"
    t.index ["community_id"], name: "index_discussions_on_community_id"
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.string "video_url"
    t.string "lesson_info"
    t.integer "likes", default: 1, null: false
    t.integer "dislikes", default: 0, null: false
    t.integer "shares"
    t.boolean "material_access"
    t.string "keywords"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id"
    t.integer "position"
    t.integer "in_red", default: 0
    t.integer "in_blue", default: 0
    t.integer "in_green", default: 0
    t.integer "out_red", default: 0
    t.integer "out_blue", default: 0
    t.integer "out_green", default: 0
    t.bigint "user_id"
    t.index ["course_id"], name: "index_lessons_on_course_id"
    t.index ["user_id"], name: "index_lessons_on_user_id"
  end

  create_table "materials", force: :cascade do |t|
    t.string "category"
    t.string "title"
    t.string "file_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lesson_id"
    t.index ["lesson_id"], name: "index_materials_on_lesson_id"
  end

  create_table "memberships", id: false, force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "community_id"
    t.index ["community_id"], name: "index_memberships_on_community_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "student"
    t.string "display_name"
    t.string "referred_by"
    t.index ["display_name"], name: "index_users_on_display_name", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "views", id: false, force: :cascade do |t|
    t.integer "lesson_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "lesson_id"
    t.index ["lesson_id"], name: "index_views_on_lesson_id"
    t.index ["user_id"], name: "index_views_on_user_id"
  end

  add_foreign_key "materials", "lessons"
end
