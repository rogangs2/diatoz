# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_28_182930) do
  create_table "authors", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_authors_on_email", unique: true
  end

  create_table "blocked_users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "subscriber_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_blocked_users_on_author_id"
    t.index ["subscriber_id"], name: "index_blocked_users_on_subscriber_id"
  end

  create_table "blogs", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "author_id", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_blogs_on_author_id"
  end

  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.bigint "subscriber_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["subscriber_id"], name: "index_comments_on_subscriber_id"
  end

  create_table "posts", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "blog_id", null: false
    t.bigint "author_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["blog_id"], name: "index_posts_on_blog_id"
  end

  create_table "subscribers", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_subscribers_on_email", unique: true
  end

  add_foreign_key "blocked_users", "authors"
  add_foreign_key "blocked_users", "subscribers"
  add_foreign_key "blogs", "authors"
  add_foreign_key "comments", "subscribers"
  add_foreign_key "posts", "authors"
  add_foreign_key "posts", "blogs"
end
