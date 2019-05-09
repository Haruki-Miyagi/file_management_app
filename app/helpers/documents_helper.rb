module DocumentsHelper
  def update_pagination_partial_path(documents)
    if documents.next_page
      'rooms/rooms_pagination_page/update_pagination'
    else
      'rooms/rooms_pagination_page/remove_pagination'
    end
  end
end
