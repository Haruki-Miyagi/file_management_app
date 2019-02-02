class UploadFileService
  def initialize(params = {})
    @file_name = change_file_name(params[:file_name], params[:file_date])
    @uploaded_file = params[:file_date]
    @description = params[:description]
    @user_id = params[:user_id]
    @room_id = params[:room_id]
  end

  def define_params
    {
      file_name:    @file_name,
      uploaded_file: @uploaded_file,
      description: @description,
      user_id:   @user_id,
      room_id:   @room_id
    }.with_indifferent_access.freeze
  end

  private

  def change_file_name(file_name, uploaded_file)
    return nil if uploaded_file.blank?

    if file_name.present?
      extname = File.extname(uploaded_file.original_filename)
      file_name + extname
    else
      uploaded_file.original_filename
    end
  end
end
