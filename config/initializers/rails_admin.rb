require Rails.root.join("lib", "rails_admin", "statistics.rb")

RailsAdmin.config do |config|
  config.authorize_with :cancancan
  config.main_app_name = ["Hotel Manager", "Royal Hotel"]
  config.parent_controller = "ApplicationController"
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method &:current_user
  config.default_items_per_page = 5
  config.excluded_models = %w[Review ActiveStorage::Blob ActiveStorage::Attachment ActiveStorage::VariantRecord]
  config.model "User" do
    list do
      configure :password_digest do
        visible do
          bindings[:view].current_user.role.to_sym == :admin
        end
      end
      configure :remember_digest do
        visible do
          bindings[:view].current_user.role.to_sym == :admin
        end
      end
    end

    create do
      configure :remember_digest do
        visible false
      end
      configure :activation_digest do
        visible false
      end
      configure :reset_digest do
        visible false
      end
      configure :reset_sent_at do
        visible false
      end
      configure :activated, :hidden do
        default_value true
      end
      configure :activated_at do
        default_value DateTime.now, format: :long
      end
      exclude_fields :bookings, :rooms, :reviews, :payments
    end

    edit do
      configure :email do
        visible false
      end
      configure :remember_digest do
        visible false
      end
      configure :activation_digest do
        visible false
      end
      configure :reset_digest do
        visible false
      end
      configure :reset_sent_at do
        visible false
      end
      configure :activated, :hidden do
        default_value true
      end
      configure :activated_at do
        default_value DateTime.now, format: :long
      end
      exclude_fields :bookings, :rooms, :reviews, :payments
    end
  end
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
