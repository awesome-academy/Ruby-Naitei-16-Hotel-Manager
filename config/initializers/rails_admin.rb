require Rails.root.join("lib", "rails_admin", "statistics.rb")

RailsAdmin.config do |config|
  config.authorize_with :cancancan
  config.parent_controller = "ApplicationController"
  config.current_user_method { current_user }

  config.excluded_models = %w[Review ActiveStorage::Blob ActiveStorage::Attachment ActiveStorage::VariantRecord]

  config.actions do
    dashboard
    statistics

    index                         # mandatory
    new
    bulk_delete
    show
    edit
    delete

    # thay bang gem khac
    history_index
    history_show
  end
end
