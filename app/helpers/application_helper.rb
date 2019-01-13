module ApplicationHelper
  # フォーム画面のエラーメッセージを表示する
  def resource_error_messages!(resource = nil)
    return '' if resource.errors.blank?
    html = []
    html << content_tag(:div, class: 'alert alert-danger', role: 'alert') do
      content_tag(:ul) do
        resource.errors.full_messages.each do |error_message|
          concat content_tag(:li, error_message.to_s)
        end
      end
    end
    safe_join html
  end
end
