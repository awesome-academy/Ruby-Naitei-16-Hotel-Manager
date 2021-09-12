module ApplicationHelper
  def full_title page_title
    base_title = t "layouts.root_title"
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end

  def format_date_time date_time
    date_time.strftime Settings.format_date_time
  end

  def boolean_to_text value
    value ? t(".yes_t") : t(".no_t")
  end

  def status_btn_color value
    value ? "btn-success" : "btn-warning"
  end

  def toastr_flash_class type
    case type
    when "alert"
      "toastr.error"
    when "notice"
      "toastr.success"
    else
      "toastr.#{type}"
    end
  end
end
