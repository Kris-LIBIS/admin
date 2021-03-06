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

ActiveRecord::Schema.define(version: 2019_03_26_140000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "access_rights", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "description"
    t.integer "lock_version", default: 0, null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversion_jobs", force: :cascade do |t|
    t.integer "order", null: false
    t.string "format_filter"
    t.string "filename_filter"
    t.jsonb "config"
    t.bigint "manifestation_id"
    t.bigint "converter_id"
    t.index ["config"], name: "index_conversion_jobs_on_config", using: :gin
    t.index ["converter_id"], name: "index_conversion_jobs_on_converter_id"
    t.index ["manifestation_id"], name: "index_conversion_jobs_on_manifestation_id"
    t.index ["order"], name: "index_conversion_jobs_on_order"
  end

  create_table "converters", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "class_name"
    t.jsonb "parameters", array: true
    t.index ["parameters"], name: "index_converters_on_parameters", using: :gin
  end

  create_table "formats", force: :cascade do |t|
    t.string "name", null: false
    t.string "category"
    t.string "description"
    t.string "mime_types", array: true
    t.string "puids", array: true
    t.string "extensions", array: true
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["category"], name: "index_formats_on_category"
    t.index ["extensions"], name: "index_formats_on_extensions", using: :gin
    t.index ["mime_types"], name: "index_formats_on_mime_types", using: :gin
    t.index ["name"], name: "index_formats_on_name", unique: true
    t.index ["puids"], name: "index_formats_on_puids", using: :gin
  end

  create_table "ingest_agreements", force: :cascade do |t|
    t.string "name", null: false
    t.string "project_name"
    t.string "collection_name"
    t.string "contact_ingest", array: true
    t.string "contact_collection", array: true
    t.string "contact_system", array: true
    t.string "collection_description"
    t.string "ingest_job_name"
    t.bigint "producer_id", null: false
    t.bigint "material_flow_id", null: false
    t.string "collector"
    t.bigint "organization_id", null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["material_flow_id"], name: "index_ingest_agreements_on_material_flow_id"
    t.index ["name"], name: "index_ingest_agreements_on_name", unique: true
    t.index ["organization_id"], name: "index_ingest_agreements_on_organization_id"
    t.index ["producer_id"], name: "index_ingest_agreements_on_producer_id"
  end

  create_table "ingest_jobs", force: :cascade do |t|
    t.integer "order", null: false
    t.jsonb "config"
    t.bigint "ingest_agreement_id"
    t.bigint "workflow_id"
    t.index ["config"], name: "index_ingest_jobs_on_config", using: :gin
    t.index ["ingest_agreement_id"], name: "index_ingest_jobs_on_ingest_agreement_id"
    t.index ["order"], name: "index_ingest_jobs_on_order"
    t.index ["workflow_id"], name: "index_ingest_jobs_on_workflow_id"
  end

  create_table "ingest_models", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "entity_type"
    t.string "user_a"
    t.string "user_b"
    t.string "user_c"
    t.string "identifier"
    t.string "status"
    t.bigint "access_right_id", null: false
    t.bigint "retention_policy_id", null: false
    t.bigint "template_id"
    t.bigint "ingest_agreement_id", null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["access_right_id"], name: "index_ingest_models_on_access_right_id"
    t.index ["ingest_agreement_id"], name: "index_ingest_models_on_ingest_agreement_id"
    t.index ["name"], name: "index_ingest_models_on_name", unique: true
    t.index ["retention_policy_id"], name: "index_ingest_models_on_retention_policy_id"
    t.index ["template_id"], name: "index_ingest_models_on_template_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "type", null: false
    t.string "name", null: false
    t.string "label"
    t.bigint "parent_id"
    t.bigint "package_id"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["package_id"], name: "index_items_on_package_id"
    t.index ["parent_id"], name: "index_items_on_parent_id"
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti", unique: true
  end

  create_table "manifestations", force: :cascade do |t|
    t.integer "order", null: false
    t.string "name", null: false
    t.string "label", null: false
    t.boolean "optional", default: false
    t.bigint "access_right_id"
    t.bigint "representation_info_id", null: false
    t.bigint "from_id"
    t.bigint "ingest_model_id", null: false
    t.index ["access_right_id"], name: "index_manifestations_on_access_right_id"
    t.index ["from_id"], name: "index_manifestations_on_from_id"
    t.index ["ingest_model_id"], name: "index_manifestations_on_ingest_model_id"
    t.index ["order"], name: "index_manifestations_on_order"
    t.index ["representation_info_id"], name: "index_manifestations_on_representation_info_id"
  end

  create_table "material_flows", force: :cascade do |t|
    t.string "name", null: false
    t.string "ext_id", null: false
    t.string "inst_code"
    t.string "description"
    t.integer "lock_version", default: 0, null: false
    t.index ["inst_code", "name"], name: "index_material_flows_on_inst_code_and_name", unique: true
  end

# Could not dump table "memberships" because of following StandardError
#   Unknown type 'user_role' for column 'role'

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "inst_code"
    t.string "ingest_dir"
    t.jsonb "upload_areas", default: "{}", null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["upload_areas"], name: "index_organizations_on_upload_areas", using: :gin
  end

  create_table "packages", force: :cascade do |t|
    t.string "name", null: false
    t.string "stage"
    t.string "status"
    t.string "base_dir"
    t.jsonb "config"
    t.bigint "ingest_agreement_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["ingest_agreement_id"], name: "index_packages_on_ingest_agreement_id"
  end

  create_table "producers", force: :cascade do |t|
    t.string "name", null: false
    t.string "ext_id", null: false
    t.string "inst_code", null: false
    t.string "description"
    t.string "agent", null: false
    t.string "password", null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["inst_code", "name"], name: "index_producers_on_inst_code_and_name", unique: true
  end

  create_table "representation_infos", force: :cascade do |t|
    t.string "name", null: false
    t.string "preservation_type", null: false
    t.string "usage_type"
    t.string "representation_code"
    t.integer "lock_version", default: 0, null: false
    t.index ["name"], name: "index_representation_infos_on_name", unique: true
    t.index ["preservation_type"], name: "index_representation_infos_on_preservation_type"
  end

  create_table "retention_policies", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "description"
    t.integer "lock_version", default: 0, null: false
  end

  create_table "status_logs", force: :cascade do |t|
    t.string "task"
    t.string "status"
    t.integer "progess"
    t.integer "max"
    t.bigint "item_id"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["item_id"], name: "index_status_logs_on_item_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lock_version", default: 0, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "workflows", force: :cascade do |t|
    t.string "stage"
    t.string "name"
    t.string "description"
    t.jsonb "tasks", array: true
    t.jsonb "inputs", array: true
    t.index ["inputs"], name: "index_workflows_on_inputs", using: :gin
    t.index ["tasks"], name: "index_workflows_on_tasks", using: :gin
  end

  add_foreign_key "conversion_jobs", "converters"
  add_foreign_key "conversion_jobs", "manifestations"
  add_foreign_key "ingest_agreements", "material_flows"
  add_foreign_key "ingest_agreements", "organizations"
  add_foreign_key "ingest_agreements", "producers"
  add_foreign_key "ingest_jobs", "ingest_agreements"
  add_foreign_key "ingest_jobs", "workflows"
  add_foreign_key "ingest_models", "access_rights"
  add_foreign_key "ingest_models", "ingest_agreements"
  add_foreign_key "ingest_models", "ingest_models", column: "template_id"
  add_foreign_key "ingest_models", "retention_policies"
  add_foreign_key "items", "items", column: "parent_id", on_delete: :cascade
  add_foreign_key "items", "packages"
  add_foreign_key "manifestations", "access_rights"
  add_foreign_key "manifestations", "ingest_models"
  add_foreign_key "manifestations", "manifestations", column: "from_id"
  add_foreign_key "manifestations", "representation_infos"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "users"
  add_foreign_key "packages", "ingest_agreements"
  add_foreign_key "status_logs", "items"
end
