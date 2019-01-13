module ApplicationHelper
  # devise以外で使用する
  # フォーム画面のエラーメッセージの表示
  def resource_error_messages!
    return '' if @resource.errors.empty?
    html = []
    html << content_tag(:div, class: 'alert alert-danger', role: 'alert') do
      content_tag(:ul) do
        @resource.errors.full_messages.each do |error_message|
          concat content_tag(:li, error_message.to_s)
        end
      end
    end
    safe_join html
  end
end
