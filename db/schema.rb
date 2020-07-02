# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_01_152623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goal_comments", force: :cascade do |t|
    t.integer "author_id"
    t.integer "subject_id"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_goal_comments_on_author_id"
    t.index ["subject_id"], name: "index_goal_comments_on_subject_id"
  end

  create_table "goals", force: :cascade do |t|
    t.integer "author_id"
    t.boolean "private?", default: false
    t.text "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "completed?", default: false
    t.index ["author_id"], name: "index_goals_on_author_id"
  end

  create_table "user_comments", force: :cascade do |t|
    t.integer "author_id"
    t.integer "subject_id"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_user_comments_on_author_id"
    t.index ["subject_id"], name: "index_user_comments_on_subject_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "session_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_token"], name: "index_users_on_session_token"
    t.index ["username"], name: "index_users_on_username"
  end

end
