RailsAdmin.config do |config|
  config.authorize_with :cancancan
  config.parent_controller = "ApplicationController"
  config.current_user_method { current_user }

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    # export co the bo sau nay
    export
    bulk_delete
    show
    edit
    delete
    # show in app co the bo sau nay
    show_in_app

    # thay bang gem khac
    history_index
    history_show
  end
end
