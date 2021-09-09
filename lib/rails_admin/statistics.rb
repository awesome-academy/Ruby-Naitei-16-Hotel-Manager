module RailsAdmin
  module Config
    module Actions
      class Statistics < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register self

        register_instance_option :root? do
          true
        end

        register_instance_option :breadcrumb_parent do
          nil
        end

        register_instance_option :link_icon do
          "icon-star"
        end

        register_instance_option :controller do
          proc do
            @total_customer = User.count
            @total_new_customer = User.customer.new_user(
              Settings.statistic.default.month_ago
            ).count
            @new_customer = User.customer.new_user_by_month

            @total_revenue = Payment.total_revenue
            @revenue_by_month = Payment.revenue_by_month

            @booking_by_room_type = Booking.count_by_room_type.map do |k, v|
              [RoomType.find(k).name, v]
            end
            @revenue_by_room_type = Booking.count_by_room_type.map do |k, v|
              room_type = RoomType.find k
              [room_type.name, v * room_type.cost]
            end
          end
        end
      end
    end
  end
end
